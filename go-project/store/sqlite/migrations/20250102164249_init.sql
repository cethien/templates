-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS messages (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	content TEXT NOT NULL UNIQUE,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO messages (content) VALUES ('Hello, World!');
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS messages;
-- +goose StatementEnd
