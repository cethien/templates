package main

import (
	"os"
	"path"

	"example.com/go-project/store/sqlite"
	"github.com/urfave/cli/v2"
)

func init() {
	cmd.Commands = append(cmd.Commands, dbCmd)
	cmd.Flags = append(cmd.Flags, configFlags...)
}

var (
	dbCmd = &cli.Command{
		Name:  "database",
		Aliases: []string{"db"},
		Usage: "Database commands",
		Subcommands: []*cli.Command{
			dbMigrateCmd,
			dbRollbackCmd,
		},
	}

	dbMigrateCmd = &cli.Command{
		Name:  "migrate",
		Aliases: []string{"up"},
		Usage: "Migrate database",
		Action: func(ctx *cli.Context) error {
			return sqlite.Migrate(ctx.Context)
		},
	}

	dbRollbackCmd = &cli.Command{
		Name:  "rollback",
		Aliases: []string{"down"},
		Usage: "Rollback database",
		Action: func(ctx *cli.Context) error {
			return sqlite.Rollback(ctx.Context)
		},
	}
)

var (
	configFlags = []cli.Flag{
		&cli.StringFlag{
			Name:    "database",
			Aliases: []string{"db"},
			Usage:   "Database file path",
			EnvVars: []string{"DB_PATH", "DATABASE_PATH"},
			Required: true,
			HasBeenSet: true,
			Value:   "data/database.db",
			Action: func(ctx *cli.Context, s string) error {
				// create folder if needed
				if err := os.MkdirAll(path.Dir(s), 0755); err != nil {
					return err
				}

				if err := sqlite.Open(s); err != nil {
					return err
				}
				return sqlite.DB().Ping()
			},
		},
	}
)
