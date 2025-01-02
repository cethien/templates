package main

import (
	"context"
	"log/slog"
	"os"

	root "example.com/go-project"
	"github.com/urfave/cli/v2"
)

var (
	app = &cli.App{
		Name:  root.Meta().Name(),
		Version: root.Meta().Version(),
		HelpName: root.Meta().Name(),
	}
)

func main() {
	ctx := context.Background()
	if err := app.RunContext(ctx, os.Args); err != nil {
		slog.Error("failed to run application", slog.String("error", err.Error()))
		os.Exit(1)
	}
}
