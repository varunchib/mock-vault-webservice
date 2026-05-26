package repository

import (
	"context"
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"
	"strings"
	"time"

	"mock-vault-webservice/internal/models"
)

var ErrNotFound = errors.New("resource not found")

type GoogleUserInput struct {
	ID        string
	Email     string
	Name      string
	AvatarURL string
}

type SessionInput struct {
	ID               string
	UserID           string
	RefreshTokenHash string
	UserAgent        string
	IPAddress        string
	ExpiresAt        time.Time
}

type MockQuestionInput struct {
	Question    string
	Options     []models.QuestionOption
	AnswerKey   string
	Explanation string
	Subject     string
}

type CreateMockInput struct {
	Slug            string
	ExamSlug        string
	Title           string
	Description     string
	DurationMinutes int
	Difficulty      string
	IsFree          bool
	NegativeMarking float64
	Subjects        []string
	Questions       []MockQuestionInput
}

type PostgresRepository struct {
	db *sql.DB
}

func NewPostgresRepository(db *sql.DB) *PostgresRepository {
	return &PostgresRepository{db: db}
}

const examSelectSQL = `
	SELECT
	  e.slug, e.name, e.short_name, e.category, e.icon, e.description, e.popular_years,
	  CAST((SELECT COUNT(*) FROM vaultcore.papers p WHERE p.exam_slug = e.slug) AS text),
	  CAST((SELECT COALESCE(SUM(p2.questions),0) FROM vaultcore.papers p2 WHERE p2.exam_slug = e.slug) AS text),
	  CAST((SELECT COUNT(*) FROM vaultcore.mocks m WHERE m.exam_slug = e.slug) AS text),
	  COALESCE(
	    (SELECT array_to_json(array_agg(DISTINCT q.subject ORDER BY q.subject))
	     FROM vaultcore.questions q
	     WHERE q.exam_slug = e.slug AND q.paper_slug IS NOT NULL AND q.subject != ''),
	    '[]'::json
	  )
	FROM vaultcore.exams e`

func (r *PostgresRepository) ListExams(ctx context.Context) ([]models.Exam, error) {
	rows, err := r.db.QueryContext(ctx, examSelectSQL+` ORDER BY e.name`)
	if err != nil {
		return nil, fmt.Errorf("list exams: %w", err)
	}
	defer rows.Close()

	exams := make([]models.Exam, 0)
	for rows.Next() {
		exam, err := scanExam(rows)
		if err != nil {
			return nil, err
		}
		exams = append(exams, exam)
	}
	return exams, rows.Err()
}

func (r *PostgresRepository) GetExamBySlug(ctx context.Context, slug string) (models.Exam, error) {
	row := r.db.QueryRowContext(ctx, examSelectSQL+` WHERE e.slug = $1`, slug)
	exam, err := scanExam(row)
	if err != nil {
		return models.Exam{}, mapNotFound(err)
	}
	return exam, nil
}

func (r *PostgresRepository) ListPapers(ctx context.Context) ([]models.Paper, error) {
	rows, err := r.db.QueryContext(ctx, `
		SELECT slug, exam_slug, exam_name, title, year, shift, description, questions, subjects, negative_marking, source_url, duration_minutes, max_marks, held_on::text
		FROM vaultcore.papers
		ORDER BY exam_name, held_on DESC NULLS LAST, year DESC, title
	`)
	if err != nil {
		return nil, fmt.Errorf("list papers: %w", err)
	}
	defer rows.Close()

	papers := make([]models.Paper, 0)
	for rows.Next() {
		paper, err := scanPaper(rows)
		if err != nil {
			return nil, err
		}
		papers = append(papers, paper)
	}
	return papers, rows.Err()
}

func (r *PostgresRepository) ListPapersByExam(ctx context.Context, examSlug string) ([]models.Paper, error) {
	rows, err := r.db.QueryContext(ctx, `
		SELECT slug, exam_slug, exam_name, title, year, shift, description, questions, subjects, negative_marking, source_url, duration_minutes, max_marks, held_on::text
		FROM vaultcore.papers
		WHERE exam_slug = $1
		ORDER BY held_on DESC NULLS LAST, year DESC, title
	`, examSlug)
	if err != nil {
		return nil, fmt.Errorf("list papers by exam: %w", err)
	}
	defer rows.Close()

	papers := make([]models.Paper, 0)
	for rows.Next() {
		paper, err := scanPaper(rows)
		if err != nil {
			return nil, err
		}
		papers = append(papers, paper)
	}
	return papers, rows.Err()
}

func (r *PostgresRepository) GetPaperBySlug(ctx context.Context, slug string) (models.Paper, error) {
	row := r.db.QueryRowContext(ctx, `
		SELECT slug, exam_slug, exam_name, title, year, shift, description, questions, subjects, negative_marking, source_url, duration_minutes, max_marks, held_on::text
		FROM vaultcore.papers
		WHERE slug = $1
	`, slug)
	paper, err := scanPaper(row)
	if err != nil {
		return models.Paper{}, mapNotFound(err)
	}
	return paper, nil
}

func (r *PostgresRepository) ListQuestions(ctx context.Context) ([]models.Question, error) {
	rows, err := r.db.QueryContext(ctx, `
		SELECT slug, exam_slug, COALESCE(paper_slug, ''), exam_name, year, paper, subject, question_no, question, options, answer_key, answer, explanation, tags, translations
		FROM vaultcore.questions
		ORDER BY exam_name, year DESC, question_no::INTEGER NULLS LAST, question_no
	`)
	if err != nil {
		return nil, fmt.Errorf("list questions: %w", err)
	}
	defer rows.Close()

	questions := make([]models.Question, 0)
	for rows.Next() {
		question, err := scanQuestion(rows)
		if err != nil {
			return nil, err
		}
		questions = append(questions, question)
	}
	return questions, rows.Err()
}

func (r *PostgresRepository) ListQuestionsByExam(ctx context.Context, examSlug string) ([]models.Question, error) {
	rows, err := r.db.QueryContext(ctx, `
		SELECT slug, exam_slug, COALESCE(paper_slug, ''), exam_name, year, paper, subject, question_no, question, options, answer_key, answer, explanation, tags, translations
		FROM vaultcore.questions
		WHERE exam_slug = $1
		ORDER BY year DESC, question_no::INTEGER NULLS LAST, question_no
	`, examSlug)
	if err != nil {
		return nil, fmt.Errorf("list questions by exam: %w", err)
	}
	defer rows.Close()

	questions := make([]models.Question, 0)
	for rows.Next() {
		question, err := scanQuestion(rows)
		if err != nil {
			return nil, err
		}
		questions = append(questions, question)
	}
	return questions, rows.Err()
}

func (r *PostgresRepository) ListQuestionsByPaper(ctx context.Context, paperSlug string) ([]models.Question, error) {
	rows, err := r.db.QueryContext(ctx, `
		SELECT slug, exam_slug, COALESCE(paper_slug, ''), exam_name, year, paper, subject, question_no, question, options, answer_key, answer, explanation, tags, translations
		FROM vaultcore.questions
		WHERE paper_slug = $1
		ORDER BY question_no::INTEGER NULLS LAST, question_no
	`, paperSlug)
	if err != nil {
		return nil, fmt.Errorf("list questions by paper: %w", err)
	}
	defer rows.Close()

	var questions []models.Question
	for rows.Next() {
		question, err := scanQuestion(rows)
		if err != nil {
			return nil, err
		}
		questions = append(questions, question)
	}
	return questions, rows.Err()
}

func (r *PostgresRepository) ListQuestionsByMock(ctx context.Context, mockSlug string) ([]models.Question, error) {
	rows, err := r.db.QueryContext(ctx, `
		SELECT slug, exam_slug, COALESCE(paper_slug, ''), exam_name, year, paper, subject, question_no, question, options, answer_key, answer, explanation, tags, translations
		FROM vaultcore.questions
		WHERE mock_slug = $1
		ORDER BY question_no::INTEGER NULLS LAST, question_no
	`, mockSlug)
	if err != nil {
		return nil, fmt.Errorf("list questions by mock: %w", err)
	}
	defer rows.Close()

	questions := make([]models.Question, 0)
	for rows.Next() {
		question, err := scanQuestion(rows)
		if err != nil {
			return nil, err
		}
		questions = append(questions, question)
	}
	return questions, rows.Err()
}

func (r *PostgresRepository) GetQuestionBySlug(ctx context.Context, slug string) (models.Question, error) {
	row := r.db.QueryRowContext(ctx, `
		SELECT slug, exam_slug, COALESCE(paper_slug, ''), exam_name, year, paper, subject, question_no, question, options, answer_key, answer, explanation, tags, translations
		FROM vaultcore.questions
		WHERE slug = $1
	`, slug)
	question, err := scanQuestion(row)
	if err != nil {
		return models.Question{}, mapNotFound(err)
	}
	return question, nil
}

func (r *PostgresRepository) ListMocks(ctx context.Context) ([]models.MockItem, error) {
	rows, err := r.db.QueryContext(ctx, `
		SELECT slug, exam_slug, exam_name, title, description, questions, duration_minutes, difficulty, is_free, subjects, negative_marking
		FROM vaultcore.mocks
		ORDER BY exam_name, title
	`)
	if err != nil {
		return nil, fmt.Errorf("list mocks: %w", err)
	}
	defer rows.Close()

	mocks := make([]models.MockItem, 0)
	for rows.Next() {
		mock, err := scanMock(rows)
		if err != nil {
			return nil, err
		}
		mocks = append(mocks, mock)
	}
	return mocks, rows.Err()
}

func (r *PostgresRepository) GetMockBySlug(ctx context.Context, slug string) (models.MockItem, error) {
	row := r.db.QueryRowContext(ctx, `
		SELECT slug, exam_slug, exam_name, title, description, questions, duration_minutes, difficulty, is_free, subjects, negative_marking
		FROM vaultcore.mocks
		WHERE slug = $1
	`, slug)
	mock, err := scanMock(row)
	if err != nil {
		return models.MockItem{}, mapNotFound(err)
	}
	return mock, nil
}

func (r *PostgresRepository) UpsertExam(ctx context.Context, req models.AdminCreateExamRequest) error {
	popularYears := []byte("[]")
	subjectsJSON, err := json.Marshal(req.Subjects)
	if err != nil {
		return fmt.Errorf("marshal exam subjects: %w", err)
	}

	_, err = r.db.ExecContext(ctx, `
		INSERT INTO vaultcore.exams (slug, name, short_name, category, icon, total_questions, papers, mocks, description, popular_years, subjects)
		VALUES ($1, $2, $3, $4, $5, 0, 0, 0, $6, $7, $8)
		ON CONFLICT (slug) DO UPDATE SET
			name = EXCLUDED.name,
			short_name = EXCLUDED.short_name,
			category = EXCLUDED.category,
			icon = EXCLUDED.icon,
			description = EXCLUDED.description,
			subjects = EXCLUDED.subjects
	`,
		req.Slug, req.Name, req.ShortName, req.Category, req.Icon,
		req.Description, popularYears, subjectsJSON,
	)
	return err
}

func (r *PostgresRepository) DeleteExamBySlug(ctx context.Context, slug string) error {
	res, err := r.db.ExecContext(ctx, `DELETE FROM vaultcore.exams WHERE slug = $1`, slug)
	if err != nil {
		return fmt.Errorf("delete exam: %w", err)
	}
	n, _ := res.RowsAffected()
	if n == 0 {
		return ErrNotFound
	}
	return nil
}

func (r *PostgresRepository) UpsertMockWithQuestions(ctx context.Context, input CreateMockInput) error {
	tx, err := r.db.BeginTx(ctx, nil)
	if err != nil {
		return fmt.Errorf("begin mock transaction: %w", err)
	}
	defer tx.Rollback()

	var examShortName string
	row := tx.QueryRowContext(ctx, `
		SELECT short_name
		FROM vaultcore.exams
		WHERE slug = $1
	`, input.ExamSlug)
	if err := row.Scan(&examShortName); err != nil {
		return mapNotFound(err)
	}

	subjects := input.Subjects
	if len(subjects) == 0 {
		subjects = uniqueQuestionSubjects(input.Questions)
	}
	subjectsRaw, err := json.Marshal(subjects)
	if err != nil {
		return fmt.Errorf("marshal mock subjects: %w", err)
	}

	_, err = tx.ExecContext(ctx, `
		INSERT INTO vaultcore.mocks (slug, exam_slug, exam_name, title, description, questions, duration_minutes, difficulty, is_free, subjects, negative_marking, updated_at)
		VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, CURRENT_TIMESTAMP)
		ON CONFLICT (slug) DO UPDATE SET
			exam_slug = EXCLUDED.exam_slug,
			exam_name = EXCLUDED.exam_name,
			title = EXCLUDED.title,
			description = EXCLUDED.description,
			questions = EXCLUDED.questions,
			duration_minutes = EXCLUDED.duration_minutes,
			difficulty = EXCLUDED.difficulty,
			is_free = EXCLUDED.is_free,
			subjects = EXCLUDED.subjects,
			negative_marking = EXCLUDED.negative_marking,
			updated_at = CURRENT_TIMESTAMP
	`, input.Slug, input.ExamSlug, examShortName, input.Title, input.Description, len(input.Questions), input.DurationMinutes, input.Difficulty, input.IsFree, subjectsRaw, input.NegativeMarking)
	if err != nil {
		return fmt.Errorf("upsert mock: %w", err)
	}

	if _, err := tx.ExecContext(ctx, `DELETE FROM vaultcore.questions WHERE mock_slug = $1`, input.Slug); err != nil {
		return fmt.Errorf("replace mock questions: %w", err)
	}

	currentYear := fmt.Sprintf("%d", time.Now().Year())
	for index, question := range input.Questions {
		optionsRaw, err := json.Marshal(question.Options)
		if err != nil {
			return fmt.Errorf("marshal question options: %w", err)
		}
		tagsRaw, err := json.Marshal([]string{"mock", input.Slug})
		if err != nil {
			return fmt.Errorf("marshal question tags: %w", err)
		}

		answer := answerText(question.Options, question.AnswerKey)
		if answer == "" {
			answer = question.AnswerKey
		}
		subject := strings.TrimSpace(question.Subject)
		if subject == "" && len(subjects) > 0 {
			subject = subjects[0]
		}
		if subject == "" {
			subject = "General"
		}

		_, err = tx.ExecContext(ctx, `
			INSERT INTO vaultcore.questions (
				slug, exam_slug, paper_slug, mock_slug, exam_name, year, paper, subject,
				question_no, question, options, answer_key, answer, explanation, tags, updated_at
			)
			VALUES ($1, $2, NULL, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, CURRENT_TIMESTAMP)
		`,
			fmt.Sprintf("%s-q%d", input.Slug, index+1),
			input.ExamSlug,
			input.Slug,
			examShortName,
			currentYear,
			input.Title,
			subject,
			fmt.Sprintf("%d", index+1),
			question.Question,
			optionsRaw,
			strings.ToUpper(strings.TrimSpace(question.AnswerKey)),
			answer,
			question.Explanation,
			tagsRaw,
		)
		if err != nil {
			return fmt.Errorf("insert mock question: %w", err)
		}
	}

	if err := tx.Commit(); err != nil {
		return fmt.Errorf("commit mock transaction: %w", err)
	}
	return nil
}

func (r *PostgresRepository) DeleteMockBySlug(ctx context.Context, slug string) error {
	result, err := r.db.ExecContext(ctx, `DELETE FROM vaultcore.mocks WHERE slug = $1`, slug)
	if err != nil {
		return fmt.Errorf("delete mock: %w", err)
	}
	return ensureAffected(result)
}

func (r *PostgresRepository) DeletePaperBySlug(ctx context.Context, slug string) error {
	tx, err := r.db.BeginTx(ctx, nil)
	if err != nil {
		return fmt.Errorf("begin delete paper transaction: %w", err)
	}
	defer tx.Rollback()

	var examSlug string
	row := tx.QueryRowContext(ctx, `DELETE FROM vaultcore.papers WHERE slug = $1 RETURNING exam_slug`, slug)
	if err := row.Scan(&examSlug); err != nil {
		return mapNotFound(err)
	}

	if _, err := tx.ExecContext(ctx, `DELETE FROM vaultcore.questions WHERE paper_slug = $1`, slug); err != nil {
		return fmt.Errorf("delete paper questions: %w", err)
	}

	if _, err := tx.ExecContext(ctx, `
		UPDATE vaultcore.exams e
		SET
			papers          = (SELECT COUNT(*) FROM vaultcore.papers p WHERE p.exam_slug = e.slug),
			total_questions = (SELECT COUNT(*) FROM vaultcore.questions q WHERE q.exam_slug = e.slug)
		WHERE e.slug = $1`, examSlug); err != nil {
		return fmt.Errorf("update exam counts after paper delete: %w", err)
	}

	return tx.Commit()
}

func (r *PostgresRepository) UpsertPaperWithQuestions(ctx context.Context, req models.AdminCreatePaperRequest) error {
	tx, err := r.db.BeginTx(ctx, nil)
	if err != nil {
		return fmt.Errorf("begin paper transaction: %w", err)
	}
	defer tx.Rollback()

	var examShortName string
	if err := tx.QueryRowContext(ctx, `SELECT short_name FROM vaultcore.exams WHERE slug = $1`, req.ExamSlug).Scan(&examShortName); err != nil {
		return mapNotFound(err)
	}

	subjects := req.Subjects
	if len(subjects) == 0 {
		seen := map[string]bool{}
		for _, q := range req.Questions {
			s := strings.TrimSpace(q.Subject)
			if s != "" && !seen[s] {
				subjects = append(subjects, s)
				seen[s] = true
			}
		}
	}
	subjectsRaw, err := json.Marshal(subjects)
	if err != nil {
		return fmt.Errorf("marshal paper subjects: %w", err)
	}

	year := strings.TrimSpace(req.Year)
	if year == "" {
		year = fmt.Sprintf("%d", time.Now().Year())
	}

	_, err = tx.ExecContext(ctx, `
		INSERT INTO vaultcore.papers (slug, exam_slug, exam_name, title, year, shift, description, questions, subjects, negative_marking, updated_at)
		VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, CURRENT_TIMESTAMP)
		ON CONFLICT (slug) DO UPDATE SET
			exam_slug = EXCLUDED.exam_slug,
			exam_name = EXCLUDED.exam_name,
			title = EXCLUDED.title,
			year = EXCLUDED.year,
			shift = EXCLUDED.shift,
			description = EXCLUDED.description,
			questions = EXCLUDED.questions,
			subjects = EXCLUDED.subjects,
			negative_marking = EXCLUDED.negative_marking,
			updated_at = CURRENT_TIMESTAMP
	`, req.Slug, req.ExamSlug, examShortName, req.Title, year, req.Shift, req.Description, len(req.Questions), subjectsRaw, req.NegativeMarking)
	if err != nil {
		return fmt.Errorf("upsert paper: %w", err)
	}

	if _, err := tx.ExecContext(ctx, `DELETE FROM vaultcore.questions WHERE paper_slug = $1`, req.Slug); err != nil {
		return fmt.Errorf("clear paper questions: %w", err)
	}

	for i, q := range req.Questions {
		optionsRaw, err := json.Marshal(q.Options)
		if err != nil {
			return fmt.Errorf("marshal options for question %d: %w", i+1, err)
		}
		tags := q.Tags
		if tags == nil {
			tags = []string{}
		}
		tagsRaw, err := json.Marshal(tags)
		if err != nil {
			return fmt.Errorf("marshal tags for question %d: %w", i+1, err)
		}
		answer := answerText(q.Options, q.AnswerKey)
		if answer == "" {
			answer = q.AnswerKey
		}
		subject := strings.TrimSpace(q.Subject)
		if subject == "" && len(subjects) > 0 {
			subject = subjects[0]
		}
		if subject == "" {
			subject = "General"
		}
		qNo := strings.TrimSpace(q.QuestionNo)
		if qNo == "" {
			qNo = fmt.Sprintf("%d", i+1)
		}
		qSlug := fmt.Sprintf("%s-q%s", req.Slug, qNo)

		_, err = tx.ExecContext(ctx, `
			INSERT INTO vaultcore.questions (
				slug, exam_slug, paper_slug, mock_slug, exam_name, year, paper, subject,
				question_no, question, options, answer_key, answer, explanation, tags, updated_at
			)
			VALUES ($1, $2, $3, NULL, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, CURRENT_TIMESTAMP)
			ON CONFLICT (slug) DO UPDATE SET
				exam_slug = EXCLUDED.exam_slug,
				paper_slug = EXCLUDED.paper_slug,
				exam_name = EXCLUDED.exam_name,
				year = EXCLUDED.year,
				paper = EXCLUDED.paper,
				subject = EXCLUDED.subject,
				question_no = EXCLUDED.question_no,
				question = EXCLUDED.question,
				options = EXCLUDED.options,
				answer_key = EXCLUDED.answer_key,
				answer = EXCLUDED.answer,
				explanation = EXCLUDED.explanation,
				tags = EXCLUDED.tags,
				updated_at = CURRENT_TIMESTAMP
		`, qSlug, req.ExamSlug, req.Slug, examShortName, year, req.Title, subject,
			qNo, q.Question, optionsRaw,
			strings.ToUpper(strings.TrimSpace(q.AnswerKey)),
			answer, q.Explanation, tagsRaw,
		)
		if err != nil {
			return fmt.Errorf("upsert question %d: %w", i+1, err)
		}
	}

	_, err = tx.ExecContext(ctx, `
		UPDATE vaultcore.exams SET
			papers = (SELECT COUNT(*) FROM vaultcore.papers WHERE exam_slug = $1),
			total_questions = (SELECT COUNT(*) FROM vaultcore.questions WHERE exam_slug = $1),
			updated_at = CURRENT_TIMESTAMP
		WHERE slug = $1
	`, req.ExamSlug)
	if err != nil {
		return fmt.Errorf("update exam counts: %w", err)
	}

	return tx.Commit()
}

type UpdateQuestionInput struct {
	Question    string
	Options     []models.QuestionOption
	AnswerKey   string
	Explanation string
	Subject     string
	Tags        []string
}

func (r *PostgresRepository) UpdateQuestionBySlug(ctx context.Context, slug string, input UpdateQuestionInput) error {
	optionsJSON, err := json.Marshal(input.Options)
	if err != nil {
		return fmt.Errorf("marshal options: %w", err)
	}
	tags := input.Tags
	if tags == nil {
		tags = []string{}
	}
	tagsJSON, err := json.Marshal(tags)
	if err != nil {
		return fmt.Errorf("marshal tags: %w", err)
	}
	// derive answer text from options
	answerText := input.AnswerKey
	for _, opt := range input.Options {
		if strings.EqualFold(opt.Key, input.AnswerKey) {
			answerText = opt.Text
			break
		}
	}
	result, err := r.db.ExecContext(ctx, `
		UPDATE vaultcore.questions
		SET question    = $1,
		    options     = $2,
		    answer_key  = $3,
		    answer      = $4,
		    explanation = $5,
		    subject     = $6,
		    tags        = $7,
		    updated_at  = CURRENT_TIMESTAMP
		WHERE slug = $8
	`, input.Question, optionsJSON, input.AnswerKey, answerText, input.Explanation, input.Subject, tagsJSON, slug)
	if err != nil {
		return fmt.Errorf("update question: %w", err)
	}
	rows, err := result.RowsAffected()
	if err != nil {
		return fmt.Errorf("update question rows affected: %w", err)
	}
	if rows == 0 {
		return ErrNotFound
	}
	return nil
}

func (r *PostgresRepository) DeleteQuestionBySlug(ctx context.Context, slug string) error {
	tx, err := r.db.BeginTx(ctx, nil)
	if err != nil {
		return fmt.Errorf("begin delete question transaction: %w", err)
	}
	defer tx.Rollback()

	var mockSlug sql.NullString
	row := tx.QueryRowContext(ctx, `DELETE FROM vaultcore.questions WHERE slug = $1 RETURNING mock_slug`, slug)
	if err := row.Scan(&mockSlug); err != nil {
		return mapNotFound(err)
	}

	if mockSlug.Valid && strings.TrimSpace(mockSlug.String) != "" {
		if _, err := tx.ExecContext(ctx, `
			UPDATE vaultcore.mocks
			SET questions = (
				SELECT COUNT(*)
				FROM vaultcore.questions
				WHERE mock_slug = $1
			),
			updated_at = CURRENT_TIMESTAMP
			WHERE slug = $1
		`, mockSlug.String); err != nil {
			return fmt.Errorf("update mock question count: %w", err)
		}
	}

	if err := tx.Commit(); err != nil {
		return fmt.Errorf("commit delete question transaction: %w", err)
	}
	return nil
}

func (r *PostgresRepository) UpsertGoogleUser(ctx context.Context, input GoogleUserInput) (models.User, error) {
	row := r.db.QueryRowContext(ctx, `
		INSERT INTO vaultcore.users (id, email, name, avatar_url, last_login, updated_at)
		VALUES ($1, LOWER($2), $3, $4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
		ON CONFLICT (id) DO UPDATE SET
			email = LOWER(EXCLUDED.email),
			name = EXCLUDED.name,
			avatar_url = EXCLUDED.avatar_url,
			last_login = CURRENT_TIMESTAMP,
			updated_at = CURRENT_TIMESTAMP
		RETURNING id, email, name, COALESCE(avatar_url, ''), role, last_login
	`, input.ID, input.Email, input.Name, input.AvatarURL)

	var user models.User
	if err := row.Scan(&user.ID, &user.Email, &user.Name, &user.AvatarURL, &user.Role, &user.LastLogin); err != nil {
		return models.User{}, fmt.Errorf("upsert user: %w", err)
	}
	user.Email = strings.ToLower(user.Email)
	return user, nil
}

func (r *PostgresRepository) CountUsers(ctx context.Context) (int, error) {
	var count int
	err := r.db.QueryRowContext(ctx, `SELECT COUNT(*) FROM vaultcore.users WHERE is_active = TRUE`).Scan(&count)
	if err != nil {
		return 0, fmt.Errorf("count users: %w", err)
	}
	return count, nil
}

func (r *PostgresRepository) GetUserByID(ctx context.Context, id string) (models.User, error) {
	row := r.db.QueryRowContext(ctx, `
		SELECT id, email, name, COALESCE(avatar_url, ''), role, last_login
		FROM vaultcore.users
		WHERE id = $1 AND is_active = TRUE
	`, id)

	var user models.User
	if err := row.Scan(&user.ID, &user.Email, &user.Name, &user.AvatarURL, &user.Role, &user.LastLogin); err != nil {
		return models.User{}, mapNotFound(err)
	}
	return user, nil
}

func (r *PostgresRepository) CreateSession(ctx context.Context, input SessionInput) error {
	_, err := r.db.ExecContext(ctx, `
		INSERT INTO vaultcore.auth_sessions (id, user_id, refresh_token_hash, user_agent, ip_address, expires_at)
		VALUES ($1, $2, $3, $4, $5, $6)
	`, input.ID, input.UserID, input.RefreshTokenHash, input.UserAgent, input.IPAddress, input.ExpiresAt)
	if err != nil {
		return fmt.Errorf("create session: %w", err)
	}
	return nil
}

func (r *PostgresRepository) GetSessionByHash(ctx context.Context, tokenHash string) (models.Session, error) {
	row := r.db.QueryRowContext(ctx, `
		SELECT id, user_id, refresh_token_hash, COALESCE(user_agent, ''), COALESCE(ip_address, ''), expires_at, last_seen_at, revoked_at
		FROM vaultcore.auth_sessions
		WHERE refresh_token_hash = $1
	`, tokenHash)
	session, err := scanSession(row)
	if err != nil {
		return models.Session{}, mapNotFound(err)
	}
	return session, nil
}

func (r *PostgresRepository) GetSessionByID(ctx context.Context, sessionID string) (models.Session, error) {
	row := r.db.QueryRowContext(ctx, `
		SELECT id, user_id, refresh_token_hash, COALESCE(user_agent, ''), COALESCE(ip_address, ''), expires_at, last_seen_at, revoked_at
		FROM vaultcore.auth_sessions
		WHERE id = $1
	`, sessionID)
	session, err := scanSession(row)
	if err != nil {
		return models.Session{}, mapNotFound(err)
	}
	return session, nil
}

func (r *PostgresRepository) RotateSession(ctx context.Context, sessionID, nextTokenHash, userAgent, ipAddress string, expiresAt time.Time) error {
	_, err := r.db.ExecContext(ctx, `
		UPDATE vaultcore.auth_sessions
		SET refresh_token_hash = $2,
		    user_agent = $3,
		    ip_address = $4,
		    expires_at = $5,
		    last_seen_at = CURRENT_TIMESTAMP,
		    updated_at = CURRENT_TIMESTAMP,
		    revoked_at = NULL
		WHERE id = $1
	`, sessionID, nextTokenHash, userAgent, ipAddress, expiresAt)
	if err != nil {
		return fmt.Errorf("rotate session: %w", err)
	}
	return nil
}

func (r *PostgresRepository) RevokeSession(ctx context.Context, sessionID string) error {
	_, err := r.db.ExecContext(ctx, `
		UPDATE vaultcore.auth_sessions
		SET revoked_at = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP
		WHERE id = $1
	`, sessionID)
	if err != nil {
		return fmt.Errorf("revoke session: %w", err)
	}
	return nil
}

type rowScanner interface {
	Scan(dest ...any) error
}

func scanExam(row rowScanner) (models.Exam, error) {
	var exam models.Exam
	var popularYearsRaw []byte
	var subjectsRaw []byte

	if err := row.Scan(
		&exam.Slug,
		&exam.Name,
		&exam.ShortName,
		&exam.Category,
		&exam.Icon,
		&exam.Description,
		&popularYearsRaw,
		&exam.Papers,
		&exam.TotalQuestions,
		&exam.Mocks,
		&subjectsRaw,
	); err != nil {
		return models.Exam{}, err
	}

	if err := json.Unmarshal(popularYearsRaw, &exam.PopularYears); err != nil {
		return models.Exam{}, fmt.Errorf("scan exam popular years: %w", err)
	}
	if err := json.Unmarshal(subjectsRaw, &exam.Subjects); err != nil {
		return models.Exam{}, fmt.Errorf("scan exam subjects: %w", err)
	}
	return exam, nil
}

func scanPaper(row rowScanner) (models.Paper, error) {
	var paper models.Paper
	var subjectsRaw []byte
	var heldOn sql.NullString

	if err := row.Scan(
		&paper.Slug,
		&paper.ExamSlug,
		&paper.ExamName,
		&paper.Title,
		&paper.Year,
		&paper.Shift,
		&paper.Description,
		&paper.Questions,
		&subjectsRaw,
		&paper.NegativeMarking,
		&paper.SourceURL,
		&paper.DurationMinutes,
		&paper.MaxMarks,
		&heldOn,
	); err != nil {
		return models.Paper{}, err
	}

	if err := json.Unmarshal(subjectsRaw, &paper.Subjects); err != nil {
		return models.Paper{}, fmt.Errorf("scan paper subjects: %w", err)
	}
	if heldOn.Valid {
		paper.HeldOn = &heldOn.String
	}
	return paper, nil
}

func scanQuestion(row rowScanner) (models.Question, error) {
	var question models.Question
	var optionsRaw []byte
	var tagsRaw []byte
	var translationsRaw []byte

	if err := row.Scan(
		&question.Slug,
		&question.ExamSlug,
		&question.PaperSlug,
		&question.ExamName,
		&question.Year,
		&question.Paper,
		&question.Subject,
		&question.QuestionNo,
		&question.Question,
		&optionsRaw,
		&question.AnswerKey,
		&question.Answer,
		&question.Explanation,
		&tagsRaw,
		&translationsRaw,
	); err != nil {
		return models.Question{}, err
	}

	if err := json.Unmarshal(optionsRaw, &question.Options); err != nil {
		return models.Question{}, fmt.Errorf("scan question options: %w", err)
	}
	if err := json.Unmarshal(tagsRaw, &question.Tags); err != nil {
		return models.Question{}, fmt.Errorf("scan question tags: %w", err)
	}
	if len(translationsRaw) > 0 && string(translationsRaw) != "{}" {
		if err := json.Unmarshal(translationsRaw, &question.Translations); err != nil {
			return models.Question{}, fmt.Errorf("scan question translations: %w", err)
		}
	}
	return question, nil
}

func scanMock(row rowScanner) (models.MockItem, error) {
	var mock models.MockItem
	var subjectsRaw []byte

	if err := row.Scan(
		&mock.Slug,
		&mock.ExamSlug,
		&mock.ExamName,
		&mock.Title,
		&mock.Description,
		&mock.Questions,
		&mock.DurationMinutes,
		&mock.Difficulty,
		&mock.IsFree,
		&subjectsRaw,
		&mock.NegativeMarking,
	); err != nil {
		return models.MockItem{}, err
	}

	if err := json.Unmarshal(subjectsRaw, &mock.Subjects); err != nil {
		return models.MockItem{}, fmt.Errorf("scan mock subjects: %w", err)
	}
	return mock, nil
}

func scanSession(row rowScanner) (models.Session, error) {
	var session models.Session
	if err := row.Scan(
		&session.ID,
		&session.UserID,
		&session.RefreshTokenHash,
		&session.UserAgent,
		&session.IPAddress,
		&session.ExpiresAt,
		&session.LastSeenAt,
		&session.RevokedAt,
	); err != nil {
		return models.Session{}, err
	}
	return session, nil
}

func uniqueQuestionSubjects(questions []MockQuestionInput) []string {
	seen := map[string]bool{}
	var subjects []string
	for _, question := range questions {
		subject := strings.TrimSpace(question.Subject)
		if subject == "" || seen[subject] {
			continue
		}
		seen[subject] = true
		subjects = append(subjects, subject)
	}
	return subjects
}

func answerText(options []models.QuestionOption, answerKey string) string {
	normalized := strings.ToUpper(strings.TrimSpace(answerKey))
	for _, option := range options {
		if strings.EqualFold(option.Key, normalized) {
			return option.Text
		}
	}
	return ""
}

func ensureAffected(result sql.Result) error {
	affected, err := result.RowsAffected()
	if err != nil {
		return err
	}
	if affected == 0 {
		return ErrNotFound
	}
	return nil
}

func mapNotFound(err error) error {
	if errors.Is(err, sql.ErrNoRows) {
		return ErrNotFound
	}
	return err
}

func (r *PostgresRepository) UpsertEnrollment(ctx context.Context, userID, examSlug string) error {
	_, err := r.db.ExecContext(ctx, `
		INSERT INTO vaultcore.user_enrollments (user_id, exam_slug, enrolled_at)
		VALUES ($1, $2, CURRENT_TIMESTAMP)
		ON CONFLICT (user_id, exam_slug) DO UPDATE SET enrolled_at = CURRENT_TIMESTAMP
	`, userID, examSlug)
	return err
}

func (r *PostgresRepository) DeleteEnrollment(ctx context.Context, userID, examSlug string) error {
	_, err := r.db.ExecContext(ctx, `
		DELETE FROM vaultcore.user_enrollments WHERE user_id = $1 AND exam_slug = $2
	`, userID, examSlug)
	return err
}

func (r *PostgresRepository) ListUserEnrollmentSlugs(ctx context.Context, userID string) ([]string, error) {
	rows, err := r.db.QueryContext(ctx, `
		SELECT exam_slug FROM vaultcore.user_enrollments WHERE user_id = $1 ORDER BY enrolled_at DESC
	`, userID)
	if err != nil {
		return nil, fmt.Errorf("list enrollment slugs: %w", err)
	}
	defer rows.Close()
	var slugs []string
	for rows.Next() {
		var s string
		if err := rows.Scan(&s); err != nil {
			return nil, fmt.Errorf("scan enrollment slug: %w", err)
		}
		slugs = append(slugs, s)
	}
	return slugs, rows.Err()
}

func (r *PostgresRepository) RecordAttempt(ctx context.Context, id, userID, examSlug, mockSlug, paperSlug string) error {
	var mockVal, paperVal sql.NullString
	if mockSlug != "" {
		mockVal = sql.NullString{String: mockSlug, Valid: true}
	}
	if paperSlug != "" {
		paperVal = sql.NullString{String: paperSlug, Valid: true}
	}
	// Determine attempt number; attempt 1 is official, subsequent are practice
	attemptNum, err := r.GetNextAttemptNumber(ctx, userID, examSlug, mockSlug, paperSlug)
	if err != nil {
		attemptNum = 1
	}
	isOfficial := attemptNum == 1
	_, err = r.db.ExecContext(ctx, `
		INSERT INTO vaultcore.user_attempts
			(id, user_id, exam_slug, mock_slug, paper_slug, score, total_questions,
			 correct_answers, wrong_answers, skipped_answers, time_taken_seconds, answers,
			 attempt_number, is_official)
		VALUES ($1, $2, $3, $4, $5, 0, 0, 0, 0, 0, 0, '{}', $6, $7)
	`, id, userID, examSlug, mockVal, paperVal, attemptNum, isOfficial)
	return err
}

func (r *PostgresRepository) ListUserEnrollments(ctx context.Context, userID string) ([]models.Exam, error) {
	rows, err := r.db.QueryContext(ctx, examSelectSQL+`
		JOIN vaultcore.user_enrollments ue ON ue.exam_slug = e.slug
		WHERE ue.user_id = $1
		ORDER BY ue.enrolled_at DESC
		LIMIT 8
	`, userID)
	if err != nil {
		return nil, fmt.Errorf("list user enrollments: %w", err)
	}
	defer rows.Close()

	exams := make([]models.Exam, 0)
	for rows.Next() {
		exam, err := scanExam(rows)
		if err != nil {
			return nil, err
		}
		exams = append(exams, exam)
	}
	return exams, rows.Err()
}

func (r *PostgresRepository) ListUserRecentAttempts(ctx context.Context, userID string, limit int) ([]models.RecentAttempt, error) {
	rows, err := r.db.QueryContext(ctx, `
		SELECT type, slug, exam_slug, exam_name, title, questions, completed_at
		FROM (
			SELECT DISTINCT ON (
				CASE WHEN ua.paper_slug IS NOT NULL THEN 'paper' ELSE 'mock' END,
				COALESCE(ua.paper_slug, ua.mock_slug, '')
			)
				CASE WHEN ua.paper_slug IS NOT NULL THEN 'paper' ELSE 'mock' END AS type,
				COALESCE(ua.paper_slug, ua.mock_slug, '') AS slug,
				ua.exam_slug,
				COALESCE(e.short_name, '') AS exam_name,
				COALESCE(p.title, m.title, '') AS title,
				COALESCE(p.questions, m.questions, 0) AS questions,
				ua.completed_at
			FROM vaultcore.user_attempts ua
			LEFT JOIN vaultcore.papers p ON ua.paper_slug = p.slug
			LEFT JOIN vaultcore.mocks m ON ua.mock_slug = m.slug
			LEFT JOIN vaultcore.exams e ON ua.exam_slug = e.slug
			WHERE ua.user_id = $1
			ORDER BY
				CASE WHEN ua.paper_slug IS NOT NULL THEN 'paper' ELSE 'mock' END,
				COALESCE(ua.paper_slug, ua.mock_slug, ''),
				ua.completed_at DESC
		) deduped
		ORDER BY completed_at DESC
		LIMIT $2
	`, userID, limit)
	if err != nil {
		return nil, fmt.Errorf("list user recent attempts: %w", err)
	}
	defer rows.Close()

	attempts := make([]models.RecentAttempt, 0)
	for rows.Next() {
		var a models.RecentAttempt
		if err := rows.Scan(&a.Type, &a.Slug, &a.ExamSlug, &a.ExamName, &a.Title, &a.Questions, &a.AttemptedAt); err != nil {
			return nil, fmt.Errorf("scan recent attempt: %w", err)
		}
		attempts = append(attempts, a)
	}
	return attempts, rows.Err()
}

func (r *PostgresRepository) UpdateAttemptResult(ctx context.Context, attemptID string, correct, wrong, skipped, timeTaken int, answers map[string]string) error {
	answersJSON, err := json.Marshal(answers)
	if err != nil {
		return fmt.Errorf("marshal answers: %w", err)
	}
	total := correct + wrong + skipped
	_, err = r.db.ExecContext(ctx, `
		UPDATE vaultcore.user_attempts
		SET score              = $1,
		    total_questions    = $2,
		    correct_answers    = $3,
		    wrong_answers      = $4,
		    skipped_answers    = $5,
		    time_taken_seconds = $6,
		    answers            = $7,
		    completed_at       = CURRENT_TIMESTAMP
		WHERE id = $8
	`, correct, total, correct, wrong, skipped, timeTaken, string(answersJSON), attemptID)
	if err != nil {
		return fmt.Errorf("update attempt result: %w", err)
	}
	return nil
}

// GetExamCutoffs returns all cutoff sets for an exam, grouped by (stage, year), newest year first.
func (r *PostgresRepository) GetExamCutoffs(ctx context.Context, examSlug string) ([]models.ExamCutoffSet, error) {
	rows, err := r.db.QueryContext(ctx, `
		SELECT stage, year, category, marks, total_marks, avg_score, std_dev, source
		FROM vaultcore.exam_cutoffs
		WHERE exam_slug = $1
		ORDER BY year DESC, stage, category
	`, examSlug)
	if err != nil {
		return nil, fmt.Errorf("get exam cutoffs: %w", err)
	}
	defer rows.Close()

	type key struct{ stage, year string }
	index := make(map[key]int)
	var sets []models.ExamCutoffSet

	for rows.Next() {
		var stage, year, category, source string
		var marks, totalMarks, avgScore, stdDev float64
		if err := rows.Scan(&stage, &year, &category, &marks, &totalMarks, &avgScore, &stdDev, &source); err != nil {
			return nil, fmt.Errorf("scan exam cutoff: %w", err)
		}
		k := key{stage, year}
		i, exists := index[k]
		if !exists {
			sets = append(sets, models.ExamCutoffSet{
				Stage:      stage,
				Year:       year,
				TotalMarks: totalMarks,
				AvgScore:   avgScore,
				StdDev:     stdDev,
			})
			i = len(sets) - 1
			index[k] = i
		}
		sets[i].Cutoffs = append(sets[i].Cutoffs, models.CutoffCategoryEntry{
			Category: category,
			Marks:    marks,
			Source:   source,
		})
	}
	if sets == nil {
		sets = []models.ExamCutoffSet{}
	}
	return sets, rows.Err()
}

// UpsertExamCutoff inserts or updates a single cutoff row.
func (r *PostgresRepository) UpsertExamCutoff(ctx context.Context, examSlug, stage, year, category, source string, marks, totalMarks, avgScore, stdDev float64) error {
	_, err := r.db.ExecContext(ctx, `
		INSERT INTO vaultcore.exam_cutoffs
			(exam_slug, stage, year, category, marks, total_marks, avg_score, std_dev, source, updated_at)
		VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,CURRENT_TIMESTAMP)
		ON CONFLICT (exam_slug, stage, year, category) DO UPDATE SET
			marks       = EXCLUDED.marks,
			total_marks = EXCLUDED.total_marks,
			avg_score   = EXCLUDED.avg_score,
			std_dev     = EXCLUDED.std_dev,
			source      = EXCLUDED.source,
			updated_at  = CURRENT_TIMESTAMP
	`, examSlug, stage, year, category, source, marks, totalMarks, avgScore, stdDev)
	return err
}

// GetNextAttemptNumber returns how many times a user has attempted a paper/mock and what their next attempt number is.
type LeaderboardEntry struct {
	Rank     int    `json:"rank"`
	UserID   string `json:"userId"`
	Name     string `json:"name"`
	ScorePct int    `json:"scorePct"`
	IsMe     bool   `json:"isMe"`
}

// GetExamLeaderboard returns the top-10 performers for an exam (by best score ratio)
// and the requesting user's rank. UserID may be empty to skip user-rank lookup.
func (r *PostgresRepository) GetExamLeaderboard(ctx context.Context, examSlug, userID string) ([]LeaderboardEntry, int, error) {
	rows, err := r.db.QueryContext(ctx, `
		WITH best AS (
			SELECT ua.user_id,
			       u.name,
			       MAX(ua.correct_answers::float / NULLIF(ua.total_questions,0)) AS ratio
			FROM vaultcore.user_attempts ua
			JOIN vaultcore.users u ON u.id = ua.user_id
			WHERE ua.exam_slug = $1
			  AND ua.total_questions > 0
			  AND ua.correct_answers > 0
			GROUP BY ua.user_id, u.name
		),
		ranked AS (
			SELECT *, DENSE_RANK() OVER (ORDER BY ratio DESC) AS rank
			FROM best
		)
		SELECT rank, user_id, name, ROUND(ratio * 100)::int
		FROM ranked
		ORDER BY rank, name
		LIMIT 10
	`, examSlug)
	if err != nil {
		return nil, -1, fmt.Errorf("leaderboard top10: %w", err)
	}
	defer rows.Close()

	var entries []LeaderboardEntry
	for rows.Next() {
		var e LeaderboardEntry
		if err := rows.Scan(&e.Rank, &e.UserID, &e.Name, &e.ScorePct); err != nil {
			return nil, -1, err
		}
		e.IsMe = userID != "" && e.UserID == userID
		entries = append(entries, e)
	}
	if err := rows.Err(); err != nil {
		return nil, -1, err
	}

	userRank := -1
	if userID != "" {
		r.db.QueryRowContext(ctx, `
			WITH best AS (
				SELECT ua.user_id,
				       MAX(ua.correct_answers::float / NULLIF(ua.total_questions,0)) AS ratio
				FROM vaultcore.user_attempts ua
				WHERE ua.exam_slug = $1
				  AND ua.total_questions > 0
				  AND ua.correct_answers > 0
				GROUP BY ua.user_id
			),
			ranked AS (
				SELECT user_id, DENSE_RANK() OVER (ORDER BY ratio DESC) AS rank
				FROM best
			)
			SELECT rank FROM ranked WHERE user_id = $2
		`, examSlug, userID).Scan(&userRank)
	}

	return entries, userRank, nil
}

func (r *PostgresRepository) GetNextAttemptNumber(ctx context.Context, userID, examSlug, mockSlug, paperSlug string) (int, error) {
	var count int
	var err error
	if paperSlug != "" {
		err = r.db.QueryRowContext(ctx, `
			SELECT COUNT(*) FROM vaultcore.user_attempts
			WHERE user_id=$1 AND exam_slug=$2 AND paper_slug=$3
		`, userID, examSlug, paperSlug).Scan(&count)
	} else {
		err = r.db.QueryRowContext(ctx, `
			SELECT COUNT(*) FROM vaultcore.user_attempts
			WHERE user_id=$1 AND exam_slug=$2 AND mock_slug=$3
		`, userID, examSlug, mockSlug).Scan(&count)
	}
	if err != nil {
		return 1, fmt.Errorf("get attempt number: %w", err)
	}
	return count + 1, nil
}
