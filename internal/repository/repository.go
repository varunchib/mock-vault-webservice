package repository

import (
	"context"
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"
	"strings"
	"time"

	"github.com/lib/pq"

	"mock-vault-webservice/internal/models"
)

var ErrNotFound = errors.New("resource not found")

type GoogleUserInput struct {
	ID        string
	Email     string
	Name      string
	AvatarURL string
	City      string
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
	  -- Counted, not stored. The stored papers/total_questions columns drift:
	  -- jkssb read papers=6/total_questions=680 against a real 8/920. Counting
	  -- also rolls a board's sub-exams up into it, matching what the exam page
	  -- actually lists. Cheap: idx_papers_exam_slug / idx_questions_exam_slug,
	  -- and the public catalog is Redis-cached.
	  (SELECT count(*) FROM vaultcore.papers p
	     WHERE p.exam_slug = e.slug
	        OR p.exam_slug IN (SELECT s.slug FROM vaultcore.exams s WHERE s.board_slug = e.slug)),
	  (SELECT count(*) FROM vaultcore.questions q
	     WHERE q.exam_slug = e.slug
	        OR q.exam_slug IN (SELECT s.slug FROM vaultcore.exams s WHERE s.board_slug = e.slug)),
	  -- Counted (so it cannot drift like the stored column did) but deliberately
	  -- NOT board-aware: unlike papers and questions, a mock belongs to the exam
	  -- it was written for and does not roll up to the board. This has to match
	  -- ExamPage's examMocks filter, or the card would advertise mocks the Mocks
	  -- tab never shows.
	  (SELECT count(*) FROM vaultcore.mocks mk WHERE mk.exam_slug = e.slug),
	  COALESCE(e.subjects, '[]'::jsonb),
	  COALESCE(e.board_slug, ''),
	  -- How many sub-exams sit under this one. Lets clients tell a standalone exam
	  -- (0) from a thin board (1, a near-duplicate of its lone child → noindex)
	  -- from a real hub (>= 2). Cheap: idx_exams_board_slug.
	  (SELECT count(*) FROM vaultcore.exams c WHERE c.board_slug = e.slug)
	FROM vaultcore.exams e`

func (r *PostgresRepository) ListExams(ctx context.Context) ([]models.Exam, error) {
	rows, err := r.db.QueryContext(ctx, examSelectSQL+` ORDER BY name`)
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
	row := r.db.QueryRowContext(ctx, examSelectSQL+` WHERE slug = $1`, slug)
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
		-- A board shows every paper beneath it: its own, plus those of the exams
		-- whose board_slug points at it. Without this a board page would go thin
		-- the moment papers are re-pointed onto its sub-exams. Uses
		-- idx_papers_exam_slug and idx_exams_board_slug.
		WHERE exam_slug = $1
		   OR exam_slug IN (SELECT slug FROM vaultcore.exams WHERE board_slug = $1)
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
		SELECT slug, exam_slug, COALESCE(paper_slug, ''), exam_name, year, paper, subject, question_no, question, options, answer_key, answer, explanation, tags, translations, COALESCE(images, '[]'::jsonb)
		FROM vaultcore.questions
		ORDER BY exam_name, year DESC,
			CASE WHEN question_no ~ '^[0-9]+$' THEN question_no::INTEGER END NULLS LAST,
			question_no
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
		SELECT slug, exam_slug, COALESCE(paper_slug, ''), exam_name, year, paper, subject, question_no, question, options, answer_key, answer, explanation, tags, translations, COALESCE(images, '[]'::jsonb)
		FROM vaultcore.questions
		-- Same rule as papers: a board aggregates its sub-exams' questions.
		WHERE exam_slug = $1
		   OR exam_slug IN (SELECT slug FROM vaultcore.exams WHERE board_slug = $1)
		ORDER BY year DESC,
			CASE WHEN question_no ~ '^[0-9]+$' THEN question_no::INTEGER END NULLS LAST,
			question_no
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
		SELECT slug, exam_slug, COALESCE(paper_slug, ''), exam_name, year, paper, subject, question_no, question, options, answer_key, answer, explanation, tags, translations, COALESCE(images, '[]'::jsonb)
		FROM vaultcore.questions
		WHERE paper_slug = $1
		ORDER BY
			CASE WHEN question_no ~ '^[0-9]+$' THEN question_no::INTEGER END NULLS LAST,
			question_no
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
		SELECT slug, exam_slug, COALESCE(paper_slug, ''), exam_name, year, paper, subject, question_no, question, options, answer_key, answer, explanation, tags, translations, COALESCE(images, '[]'::jsonb)
		FROM vaultcore.questions
		WHERE mock_slug = $1
		ORDER BY
			CASE WHEN question_no ~ '^[0-9]+$' THEN question_no::INTEGER END NULLS LAST,
			question_no
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
		SELECT slug, exam_slug, COALESCE(paper_slug, ''), exam_name, year, paper, subject, question_no, question, options, answer_key, answer, explanation, tags, translations, COALESCE(images, '[]'::jsonb)
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
			name        = EXCLUDED.name,
			short_name  = EXCLUDED.short_name,
			category    = EXCLUDED.category,
			icon        = EXCLUDED.icon,
			description = EXCLUDED.description,
			subjects    = EXCLUDED.subjects
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

	if _, err := tx.ExecContext(ctx, `
		UPDATE vaultcore.exams SET
			mocks      = (SELECT COUNT(*) FROM vaultcore.mocks WHERE exam_slug = $1),
			updated_at = CURRENT_TIMESTAMP
		WHERE slug = $1
	`, input.ExamSlug); err != nil {
		return fmt.Errorf("update exam mock count: %w", err)
	}

	if err := tx.Commit(); err != nil {
		return fmt.Errorf("commit mock transaction: %w", err)
	}
	return nil
}

func (r *PostgresRepository) DeleteMockBySlug(ctx context.Context, slug string) error {
	tx, err := r.db.BeginTx(ctx, nil)
	if err != nil {
		return fmt.Errorf("begin delete mock transaction: %w", err)
	}
	defer tx.Rollback()

	var examSlug string
	if err := tx.QueryRowContext(ctx, `DELETE FROM vaultcore.mocks WHERE slug = $1 RETURNING exam_slug`, slug).Scan(&examSlug); err != nil {
		return mapNotFound(err)
	}

	if _, err := tx.ExecContext(ctx, `
		UPDATE vaultcore.exams SET
			mocks      = (SELECT COUNT(*) FROM vaultcore.mocks WHERE exam_slug = $1),
			updated_at = CURRENT_TIMESTAMP
		WHERE slug = $1
	`, examSlug); err != nil {
		return fmt.Errorf("update exam mock count after delete: %w", err)
	}

	return tx.Commit()
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
			papers          = (SELECT COUNT(*) FROM vaultcore.papers WHERE exam_slug = $1),
			total_questions = (SELECT COUNT(*) FROM vaultcore.questions WHERE exam_slug = $1),
			subjects        = COALESCE(
				(SELECT to_jsonb(array_agg(DISTINCT q.subject ORDER BY q.subject))
				 FROM vaultcore.questions q
				 WHERE q.exam_slug = $1 AND q.paper_slug IS NOT NULL AND q.subject != ''),
				'[]'::jsonb
			),
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
		INSERT INTO vaultcore.users (id, email, name, avatar_url, city, last_login, updated_at)
		VALUES ($1, LOWER($2), $3, $4, NULLIF($5, ''), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
		ON CONFLICT (id) DO UPDATE SET
			email = LOWER(EXCLUDED.email),
			name = EXCLUDED.name,
			avatar_url = EXCLUDED.avatar_url,
			city = COALESCE(vaultcore.users.city, EXCLUDED.city),
			last_login = CURRENT_TIMESTAMP,
			updated_at = CURRENT_TIMESTAMP
		RETURNING id, email, name, COALESCE(avatar_url, ''), role, last_login
	`, input.ID, input.Email, input.Name, input.AvatarURL, input.City)

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
		&exam.BoardSlug,
		&exam.ChildExamCount,
	); err != nil {
		return models.Exam{}, err
	}
	if len(popularYearsRaw) == 0 {
		popularYearsRaw = []byte("[]")
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
	var imagesRaw []byte

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
		&imagesRaw,
	); err != nil {
		return models.Question{}, err
	}

	if err := json.Unmarshal(optionsRaw, &question.Options); err != nil {
		return models.Question{}, fmt.Errorf("scan question options: %w", err)
	}
	if err := json.Unmarshal(tagsRaw, &question.Tags); err != nil {
		return models.Question{}, fmt.Errorf("scan question tags: %w", err)
	}
	if len(imagesRaw) > 0 && string(imagesRaw) != "[]" {
		if err := json.Unmarshal(imagesRaw, &question.Images); err != nil {
			return models.Question{}, fmt.Errorf("scan question images: %w", err)
		}
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
		-- examSelectSQL aliases vaultcore.exams AS e; once aliased, the original
		-- table name is not a valid reference here.
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

// CountNewPapersForEnrollments returns, per enrolled exam, how many papers were
// added after the user enrolled — the "something new since you subscribed"
// signal the dashboard's Enrolled section surfaces as a badge.
func (r *PostgresRepository) CountNewPapersForEnrollments(ctx context.Context, userID string) (map[string]int, error) {
	rows, err := r.db.QueryContext(ctx, `
		SELECT ue.exam_slug, COUNT(p.slug)
		FROM vaultcore.user_enrollments ue
		JOIN vaultcore.papers p
		  ON p.exam_slug = ue.exam_slug
		 AND p.created_at > ue.enrolled_at
		WHERE ue.user_id = $1
		GROUP BY ue.exam_slug
	`, userID)
	if err != nil {
		return nil, fmt.Errorf("count new papers for enrollments: %w", err)
	}
	defer rows.Close()

	counts := make(map[string]int)
	for rows.Next() {
		var slug string
		var n int
		if err := rows.Scan(&slug, &n); err != nil {
			return nil, err
		}
		counts[slug] = n
	}
	return counts, rows.Err()
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

// GetExamLeaderboardTop returns the top-10 performers for an exam (by best score
// ratio). It contains no per-user data, so the result is safe to cache and share
// across all viewers.
func (r *PostgresRepository) GetExamLeaderboardTop(ctx context.Context, examSlug string) ([]LeaderboardEntry, error) {
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
		)
		SELECT user_id, name, ROUND(ratio * 100)::int AS score_pct,
		       DENSE_RANK() OVER (ORDER BY ratio DESC) AS rnk
		FROM best
		ORDER BY rnk, name
		LIMIT 10
	`, examSlug)
	if err != nil {
		return nil, fmt.Errorf("leaderboard top: %w", err)
	}
	defer rows.Close()

	var entries []LeaderboardEntry
	for rows.Next() {
		var e LeaderboardEntry
		if err := rows.Scan(&e.UserID, &e.Name, &e.ScorePct, &e.Rank); err != nil {
			return nil, err
		}
		entries = append(entries, e)
	}
	return entries, rows.Err()
}

// GetUserExamRank returns the requesting user's dense rank for an exam, or -1 if
// the user has no qualifying attempt. Cached per-user at the handler layer.
func (r *PostgresRepository) GetUserExamRank(ctx context.Context, examSlug, userID string) (int, error) {
	if strings.TrimSpace(userID) == "" {
		return -1, nil
	}
	var rank sql.NullInt64
	err := r.db.QueryRowContext(ctx, `
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
			SELECT user_id, DENSE_RANK() OVER (ORDER BY ratio DESC) AS rnk FROM best
		)
		SELECT rnk FROM ranked WHERE user_id = $2
	`, examSlug, userID).Scan(&rank)
	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return -1, nil
		}
		return -1, fmt.Errorf("user exam rank: %w", err)
	}
	if !rank.Valid {
		return -1, nil
	}
	return int(rank.Int64), nil
}

// ScoreDistribution summarises how every platform user scored on an exam:
// 10-percent buckets of each user's best score, plus a system-estimated
// cutoff (the 65th percentile of best scores). Unlike the leaderboard it
// keeps 0-correct users — the distribution should show everyone.
type ScoreDistribution struct {
	TotalUsers      int   `json:"totalUsers"`
	Buckets         []int `json:"buckets"` // 10 buckets: 0-9%, 10-19%, … 90-100%
	SystemCutoffPct int   `json:"systemCutoffPct"`
}

func (r *PostgresRepository) GetExamScoreDistribution(ctx context.Context, examSlug string) (*ScoreDistribution, error) {
	rows, err := r.db.QueryContext(ctx, `
		WITH best AS (
			SELECT ua.user_id,
			       MAX(ua.correct_answers::float / NULLIF(ua.total_questions,0)) AS ratio
			FROM vaultcore.user_attempts ua
			WHERE ua.exam_slug = $1
			  AND ua.total_questions > 0
			GROUP BY ua.user_id
		)
		SELECT LEAST(9, FLOOR(ratio * 10))::int AS bucket, COUNT(*)
		FROM best GROUP BY 1
	`, examSlug)
	if err != nil {
		return nil, fmt.Errorf("score distribution: %w", err)
	}
	defer rows.Close()

	dist := &ScoreDistribution{Buckets: make([]int, 10)}
	for rows.Next() {
		var bucket, count int
		if err := rows.Scan(&bucket, &count); err != nil {
			return nil, err
		}
		if bucket >= 0 && bucket < 10 {
			dist.Buckets[bucket] = count
			dist.TotalUsers += count
		}
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}

	var cutoff sql.NullFloat64
	err = r.db.QueryRowContext(ctx, `
		WITH best AS (
			SELECT MAX(ua.correct_answers::float / NULLIF(ua.total_questions,0)) AS ratio
			FROM vaultcore.user_attempts ua
			WHERE ua.exam_slug = $1
			  AND ua.total_questions > 0
			GROUP BY ua.user_id
		)
		SELECT PERCENTILE_CONT(0.65) WITHIN GROUP (ORDER BY ratio) FROM best
	`, examSlug).Scan(&cutoff)
	if err != nil && !errors.Is(err, sql.ErrNoRows) {
		return nil, fmt.Errorf("score distribution cutoff: %w", err)
	}
	if cutoff.Valid {
		dist.SystemCutoffPct = int(cutoff.Float64 * 100)
	}
	return dist, nil
}

// GetPaperTitlesBySlugs maps paper slugs to [title, examName] for visit lists.
func (r *PostgresRepository) GetPaperTitlesBySlugs(ctx context.Context, slugs []string) (map[string][2]string, error) {
	rows, err := r.db.QueryContext(ctx, `
		SELECT slug, title, exam_name FROM vaultcore.papers WHERE slug = ANY($1)
	`, pq.Array(slugs))
	if err != nil {
		return nil, fmt.Errorf("paper titles by slugs: %w", err)
	}
	defer rows.Close()
	out := make(map[string][2]string, len(slugs))
	for rows.Next() {
		var slug, title, examName string
		if err := rows.Scan(&slug, &title, &examName); err != nil {
			return nil, err
		}
		out[slug] = [2]string{title, examName}
	}
	return out, rows.Err()
}

// GetMockTitlesBySlugs maps mock slugs to [title, examName] for visit lists.
func (r *PostgresRepository) GetMockTitlesBySlugs(ctx context.Context, slugs []string) (map[string][2]string, error) {
	rows, err := r.db.QueryContext(ctx, `
		SELECT slug, title, exam_name FROM vaultcore.mocks WHERE slug = ANY($1)
	`, pq.Array(slugs))
	if err != nil {
		return nil, fmt.Errorf("mock titles by slugs: %w", err)
	}
	defer rows.Close()
	out := make(map[string][2]string, len(slugs))
	for rows.Next() {
		var slug, title, examName string
		if err := rows.Scan(&slug, &title, &examName); err != nil {
			return nil, err
		}
		out[slug] = [2]string{title, examName}
	}
	return out, rows.Err()
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

func (r *PostgresRepository) CountQuestions(ctx context.Context) (int, error) {
	var n int
	err := r.db.QueryRowContext(ctx, `SELECT COUNT(*) FROM vaultcore.questions`).Scan(&n)
	return n, err
}

func (r *PostgresRepository) CountPapers(ctx context.Context) (int, error) {
	var n int
	err := r.db.QueryRowContext(ctx, `SELECT COUNT(*) FROM vaultcore.papers`).Scan(&n)
	return n, err
}

func (r *PostgresRepository) CountMocks(ctx context.Context) (int, error) {
	var n int
	err := r.db.QueryRowContext(ctx, `SELECT COUNT(*) FROM vaultcore.mocks`).Scan(&n)
	return n, err
}

func (r *PostgresRepository) ListAdminUsers(ctx context.Context, limit, offset int, query string) ([]models.AdminUser, int, error) {
	q := "%" + query + "%"
	var total int
	if err := r.db.QueryRowContext(ctx, `
		SELECT COUNT(*) FROM vaultcore.users
		WHERE $1 = '%%' OR lower(name) LIKE lower($1) OR lower(email) LIKE lower($1)
	`, q).Scan(&total); err != nil {
		return nil, 0, fmt.Errorf("count users: %w", err)
	}

	rows, err := r.db.QueryContext(ctx, `
		SELECT id, email, name, role, is_active, created_at, last_login, COALESCE(city, '')
		FROM vaultcore.users
		WHERE $1 = '%%' OR lower(name) LIKE lower($1) OR lower(email) LIKE lower($1)
		ORDER BY created_at DESC
		LIMIT $2 OFFSET $3
	`, q, limit, offset)
	if err != nil {
		return nil, 0, fmt.Errorf("list users: %w", err)
	}
	defer rows.Close()

	users := make([]models.AdminUser, 0)
	for rows.Next() {
		var u models.AdminUser
		if err := rows.Scan(&u.ID, &u.Email, &u.Name, &u.Role, &u.IsActive, &u.CreatedAt, &u.LastLogin, &u.City); err != nil {
			return nil, 0, err
		}
		users = append(users, u)
	}
	return users, total, rows.Err()
}

// AnalyticsAttemptRow is one submitted attempt with enough data to rebuild the
// user-facing analytics view (subject breakdown is computed from Answers later).
type AnalyticsAttemptRow struct {
	Type             string
	Slug             string
	ExamSlug         string
	ExamName         string
	Title            string
	TotalQuestions   int
	MaxMarks         int
	NegativeMarking  float64
	Correct          int
	Wrong            int
	Skipped          int
	TimeTakenSeconds int
	CompletedAt      time.Time
	Answers          map[string]string
}

// ListUserAnalyticsRows returns a user's submitted attempts (oldest first, so
// trend charts read chronologically), joined to paper/mock/exam metadata.
func (r *PostgresRepository) ListUserAnalyticsRows(ctx context.Context, userID string) ([]AnalyticsAttemptRow, error) {
	rows, err := r.db.QueryContext(ctx, `
		SELECT
			CASE WHEN ua.paper_slug IS NOT NULL THEN 'paper' ELSE 'mock' END,
			COALESCE(ua.paper_slug, ua.mock_slug, ''),
			ua.exam_slug,
			COALESCE(e.short_name, ''),
			COALESCE(p.title, m.title, ''),
			COALESCE(NULLIF(p.questions, 0), NULLIF(m.questions, 0), ua.total_questions),
			COALESCE(p.max_marks, 0),
			COALESCE(p.negative_marking, m.negative_marking, 0),
			ua.correct_answers, ua.wrong_answers, ua.skipped_answers,
			ua.time_taken_seconds, ua.completed_at, ua.answers
		FROM vaultcore.user_attempts ua
		LEFT JOIN vaultcore.papers p ON ua.paper_slug = p.slug
		LEFT JOIN vaultcore.mocks  m ON ua.mock_slug  = m.slug
		LEFT JOIN vaultcore.exams  e ON ua.exam_slug  = e.slug
		WHERE ua.user_id = $1 AND ua.total_questions > 0
		ORDER BY ua.completed_at ASC
	`, userID)
	if err != nil {
		return nil, fmt.Errorf("list user analytics rows: %w", err)
	}
	defer rows.Close()

	out := make([]AnalyticsAttemptRow, 0)
	for rows.Next() {
		var row AnalyticsAttemptRow
		var answersRaw []byte
		if err := rows.Scan(&row.Type, &row.Slug, &row.ExamSlug, &row.ExamName, &row.Title,
			&row.TotalQuestions, &row.MaxMarks, &row.NegativeMarking,
			&row.Correct, &row.Wrong, &row.Skipped,
			&row.TimeTakenSeconds, &row.CompletedAt, &answersRaw); err != nil {
			return nil, err
		}
		row.Answers = map[string]string{}
		if len(answersRaw) > 0 {
			_ = json.Unmarshal(answersRaw, &row.Answers)
		}
		out = append(out, row)
	}
	return out, rows.Err()
}

// GetAdminUserByID returns the full admin-visible profile for one user.
func (r *PostgresRepository) GetAdminUserByID(ctx context.Context, id string) (models.AdminUser, error) {
	row := r.db.QueryRowContext(ctx, `
		SELECT id, email, name, role, is_active, created_at, last_login, COALESCE(city, '')
		FROM vaultcore.users
		WHERE id = $1
	`, id)
	var u models.AdminUser
	if err := row.Scan(&u.ID, &u.Email, &u.Name, &u.Role, &u.IsActive, &u.CreatedAt, &u.LastLogin, &u.City); err != nil {
		return models.AdminUser{}, mapNotFound(err)
	}
	return u, nil
}

// GetAdminUsersByIDs fetches several users in one round-trip. Used by the
// live-users panel, which resolves up to 20 presence IDs at once. Returned
// order is unspecified — the caller re-orders by last-seen.
func (r *PostgresRepository) GetAdminUsersByIDs(ctx context.Context, ids []string) ([]models.AdminUser, error) {
	if len(ids) == 0 {
		return []models.AdminUser{}, nil
	}
	rows, err := r.db.QueryContext(ctx, `
		SELECT id, email, name, role, is_active, created_at, last_login, COALESCE(city, '')
		FROM vaultcore.users
		WHERE id = ANY($1)
	`, pq.Array(ids))
	if err != nil {
		return nil, fmt.Errorf("get admin users by ids: %w", err)
	}
	defer rows.Close()
	users := make([]models.AdminUser, 0, len(ids))
	for rows.Next() {
		var u models.AdminUser
		if err := rows.Scan(&u.ID, &u.Email, &u.Name, &u.Role, &u.IsActive, &u.CreatedAt, &u.LastLogin, &u.City); err != nil {
			return nil, err
		}
		users = append(users, u)
	}
	return users, rows.Err()
}

// ListUserAttemptsDetailed returns a user's most recent scored attempts (papers + mocks).
func (r *PostgresRepository) ListUserAttemptsDetailed(ctx context.Context, userID string, limit int) ([]models.AdminUserAttempt, error) {
	rows, err := r.db.QueryContext(ctx, `
		SELECT
			CASE WHEN ua.paper_slug IS NOT NULL THEN 'paper' ELSE 'mock' END AS type,
			COALESCE(ua.paper_slug, ua.mock_slug, '') AS slug,
			ua.exam_slug,
			COALESCE(e.short_name, '') AS exam_name,
			COALESCE(p.title, m.title, '') AS title,
			ua.correct_answers,
			ua.total_questions,
			CASE WHEN ua.total_questions > 0
			     THEN ROUND(ua.correct_answers::float / ua.total_questions * 100)::int
			     ELSE 0 END AS score_pct,
			ua.time_taken_seconds,
			ua.completed_at
		FROM vaultcore.user_attempts ua
		LEFT JOIN vaultcore.papers p ON ua.paper_slug = p.slug
		LEFT JOIN vaultcore.mocks  m ON ua.mock_slug  = m.slug
		LEFT JOIN vaultcore.exams  e ON ua.exam_slug  = e.slug
		WHERE ua.user_id = $1
		ORDER BY ua.completed_at DESC
		LIMIT $2
	`, userID, limit)
	if err != nil {
		return nil, fmt.Errorf("list user attempts detailed: %w", err)
	}
	defer rows.Close()

	attempts := make([]models.AdminUserAttempt, 0)
	for rows.Next() {
		var a models.AdminUserAttempt
		if err := rows.Scan(&a.Type, &a.Slug, &a.ExamSlug, &a.ExamName, &a.Title,
			&a.Correct, &a.Total, &a.ScorePct, &a.TimeTakenSeconds, &a.CompletedAt); err != nil {
			return nil, err
		}
		attempts = append(attempts, a)
	}
	return attempts, rows.Err()
}

// GetUserExamRanks returns the user's leaderboard standing for every exam they
// have a qualifying attempt in — the same ranking the user sees, per exam.
func (r *PostgresRepository) GetUserExamRanks(ctx context.Context, userID string) ([]models.AdminUserExamRank, error) {
	rows, err := r.db.QueryContext(ctx, `
		WITH per_user AS (
			SELECT exam_slug, user_id,
			       MAX(correct_answers::float / NULLIF(total_questions,0)) AS ratio
			FROM vaultcore.user_attempts
			WHERE total_questions > 0 AND correct_answers > 0
			GROUP BY exam_slug, user_id
		),
		ranked AS (
			SELECT exam_slug, user_id,
			       ROUND(ratio * 100)::int AS score_pct,
			       DENSE_RANK() OVER (PARTITION BY exam_slug ORDER BY ratio DESC) AS rnk,
			       COUNT(*)     OVER (PARTITION BY exam_slug) AS total_ranked
			FROM per_user
		)
		SELECT r.exam_slug, COALESCE(e.short_name, ''), r.score_pct, r.rnk, r.total_ranked
		FROM ranked r
		LEFT JOIN vaultcore.exams e ON e.slug = r.exam_slug
		WHERE r.user_id = $1
		ORDER BY r.score_pct DESC, r.exam_slug
	`, userID)
	if err != nil {
		return nil, fmt.Errorf("get user exam ranks: %w", err)
	}
	defer rows.Close()

	ranks := make([]models.AdminUserExamRank, 0)
	for rows.Next() {
		var er models.AdminUserExamRank
		if err := rows.Scan(&er.ExamSlug, &er.ExamName, &er.ScorePct, &er.Rank, &er.TotalRanked); err != nil {
			return nil, err
		}
		ranks = append(ranks, er)
	}
	return ranks, rows.Err()
}

func (r *PostgresRepository) UpdateUserStatus(ctx context.Context, id string, isActive bool) error {
	_, err := r.db.ExecContext(ctx, `
		UPDATE vaultcore.users SET is_active = $1, updated_at = CURRENT_TIMESTAMP WHERE id = $2
	`, isActive, id)
	return err
}

// SitemapEntry is one URL row returned for sitemap generation.
type SitemapEntry struct {
	Kind      string // "exam" | "paper" | "mock_exam"
	Slug      string
	UpdatedAt time.Time
}

// InsertAuditLog appends one entry to the admin audit trail. details may be nil.
func (r *PostgresRepository) InsertAuditLog(ctx context.Context, actorID, actorEmail, action, target, ip string, details map[string]any) error {
	detailsJSON := []byte("{}")
	if details != nil {
		if b, err := json.Marshal(details); err == nil {
			detailsJSON = b
		}
	}
	_, err := r.db.ExecContext(ctx, `
		INSERT INTO vaultcore.admin_audit_log (actor_id, actor_email, action, target, details, ip_address)
		VALUES ($1, $2, $3, $4, $5, $6)
	`, actorID, actorEmail, action, target, detailsJSON, ip)
	if err != nil {
		return fmt.Errorf("insert audit log: %w", err)
	}
	return nil
}

// ListAuditLog returns the most recent audit entries, newest first.
func (r *PostgresRepository) ListAuditLog(ctx context.Context, limit int) ([]models.AuditEntry, error) {
	rows, err := r.db.QueryContext(ctx, `
		SELECT id, actor_id, actor_email, action, target, details, ip_address, created_at
		FROM vaultcore.admin_audit_log
		ORDER BY created_at DESC, id DESC
		LIMIT $1
	`, limit)
	if err != nil {
		return nil, fmt.Errorf("list audit log: %w", err)
	}
	defer rows.Close()

	entries := make([]models.AuditEntry, 0)
	for rows.Next() {
		var e models.AuditEntry
		var details []byte
		if err := rows.Scan(&e.ID, &e.ActorID, &e.ActorEmail, &e.Action, &e.Target, &details, &e.IPAddress, &e.CreatedAt); err != nil {
			return nil, err
		}
		e.Details = json.RawMessage(details)
		entries = append(entries, e)
	}
	return entries, rows.Err()
}

func (r *PostgresRepository) ListSitemapEntries(ctx context.Context) ([]SitemapEntry, error) {
	rows, err := r.db.QueryContext(ctx, `
		-- Exam hubs. Include an exam that has real content of its own OR rolled up
		-- from its sub-exams (counted, so the drifting stored papers column can't
		-- leak). Skip a THIN board — one with exactly ONE sub-exam — because its
		-- page just aggregates that lone child and is a near-duplicate of it; it
		-- stays out of the index until a 2nd sub-exam makes it a genuine hub. This
		-- replaces the old hand-kept allowlist and is fully automatic: add a second
		-- exam under a board and it starts appearing here on the next rebuild.
		SELECT 'exam', e.slug, e.updated_at
		FROM vaultcore.exams e
		WHERE ((SELECT count(*) FROM vaultcore.papers p
		          WHERE p.exam_slug = e.slug
		             OR p.exam_slug IN (SELECT s.slug FROM vaultcore.exams s WHERE s.board_slug = e.slug)) >= 1
		    OR (SELECT count(*) FROM vaultcore.mocks mk WHERE mk.exam_slug = e.slug) >= 1)
		  AND (SELECT count(*) FROM vaultcore.exams c WHERE c.board_slug = e.slug) <> 1
		UNION ALL
		-- Skip near-empty papers (too thin to index → Google marks them Soft 404).
		-- Count real question rows, not the stored column, so stale counts can't leak.
		SELECT 'paper', p.slug, p.updated_at
		FROM vaultcore.papers p
		WHERE (SELECT count(*) FROM vaultcore.questions q WHERE q.paper_slug = p.slug) >= 5
		UNION ALL
		-- Mock hubs are intentionally omitted while the Mocks feature is gated
		-- ("coming soon") in the app: a /mock-test page cannot be attempted yet,
		-- so it must not be advertised for indexing (the Worker also serves it
		-- noindex). Re-enable this block when mocks launch:
		--   SELECT 'mock_exam', m.exam_slug, MAX(m.updated_at)
		--   FROM vaultcore.mocks m
		--   WHERE EXISTS (SELECT 1 FROM vaultcore.questions q WHERE q.mock_slug = m.slug)
		--   GROUP BY m.exam_slug
		--   UNION ALL
		-- Individual solved-question pages. The question must belong to an
		-- indexable paper (>= 5 questions) and carry a real explanation. The
		-- threshold is 100 chars, not the old 300: a solved-MCQ page also has
		-- the question, four options, the correct answer, subject and tags, so
		-- a one-sentence explanation is still a substantial, unique page. 300
		-- was dropping ~1,100 legitimate pages; 100 keeps everything except the
		-- handful of true one-line stubs that Google could flag as thin.
		SELECT 'question', q.slug, q.updated_at
		FROM vaultcore.questions q
		WHERE q.paper_slug IS NOT NULL
		  AND length(trim(q.explanation)) >= 100
		  AND (SELECT count(*) FROM vaultcore.questions q2 WHERE q2.paper_slug = q.paper_slug) >= 5
		ORDER BY 1, 2
	`)
	if err != nil {
		return nil, fmt.Errorf("list sitemap entries: %w", err)
	}
	defer rows.Close()
	var entries []SitemapEntry
	for rows.Next() {
		var e SitemapEntry
		if err := rows.Scan(&e.Kind, &e.Slug, &e.UpdatedAt); err != nil {
			return nil, err
		}
		entries = append(entries, e)
	}
	return entries, rows.Err()
}
