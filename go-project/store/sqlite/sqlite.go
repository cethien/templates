package sqlite

import (
	"context"
	"database/sql"
	"embed"

	"example.com/go-project/store/sqlite/queries"
	_ "modernc.org/sqlite"

	"github.com/pressly/goose/v3"
)

var (
	db *sql.DB
	q queries.Queries
)

//go:embed migrations/*.sql
var embeddedMigrations embed.FS

func init() {
	goose.SetDialect("sqlite")
	goose.SetBaseFS(embeddedMigrations)
}

func DB() *sql.DB {
	return db
}

func Queries() queries.Queries {
	return q
}

func Open(connStr string) error {
	var err error
	db, err = sql.Open("sqlite", connStr)
	if err != nil {
		return err
	}
	q = queries.New(db)
	return nil
}

func Migrate(ctx context.Context) error {
	return goose.UpByOneContext(ctx, db, "migrations")
}

func Rollback(ctx context.Context) error {
	return goose.DownContext(ctx, db, "migrations")
}


