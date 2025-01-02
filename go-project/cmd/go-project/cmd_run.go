package main

import (
	"log/slog"

	"example.com/go-project/store/sqlite"
	"github.com/urfave/cli/v2"
)

func init() {
	cmd.Commands = append(cmd.Commands, runCmd)
}

var (
	runCmd = &cli.Command{
		Name:  "run",
		Usage: "Run the application",
		Action: runCmdAction,
	}
)

func runCmdAction(c *cli.Context) error {
	msg, err := sqlite.Queries().SelectMessage(c.Context)
	if err != nil {
		return err
	}
	slog.Info(msg)
	return sqlite.DB().Close()
}
