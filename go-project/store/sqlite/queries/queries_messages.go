package queries

import "context"

const selectMessageQuery = `
SELECT content FROM messages LIMIT 1
`

func (q Queries) SelectMessage(ctx context.Context) (string, error) {
	var msg string
	if err := q.db.QueryRowContext(ctx, selectMessageQuery).Scan(&msg); err != nil {
		return "", err
	}
	return msg, nil
}
