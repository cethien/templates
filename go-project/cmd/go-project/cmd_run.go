package main

import (
	"log/slog"

	"github.com/urfave/cli/v2"
)

func init() {
	app.Commands = append(app.Commands, runCmd)
}

var (
	runCmd = &cli.Command{
		Name:  "run",
		Usage: "Run the application",
		Action: runCmdAction,
	}
)

func runCmdAction(c *cli.Context) error {
	slog.Info("Hello, world!")
	return nil
}
