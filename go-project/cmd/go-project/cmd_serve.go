package main

import (
	"context"
	"errors"
	"log/slog"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	"example.com/go-project/web"
	"github.com/urfave/cli/v2"
)

func init() {
	app.Commands = append(app.Commands, serveCmd)
}

var (
	serveCmd = &cli.Command{
		Name:  "serve",
		Usage: "Runs a web server",
		Flags: serveFlags,
		Action: serveCmdAction,
	}

	serveFlags = []cli.Flag{
		&cli.IntFlag{
			Name:    "port",
			Aliases: []string{"p"},
			Usage:   "HTTP Port to listen on",
			EnvVars: []string{"HTTP_PORT", "PORT"},
			Required: true,
			HasBeenSet: true,
			Value:   DefaultHTTPPort,
			Action: func(ctx *cli.Context, i int) error {
				httpServer = web.HTTPServer(i)
				return nil
			},
		},
	}
)

var httpServer *http.Server

func serveCmdAction(c *cli.Context) error {
	if httpServer == nil {
		return errors.New("http server not initialized")
	};

	go func() {
		if err := httpServer.ListenAndServe(); err != nil {
			slog.Error("failed to start http server", slog.String("error", err.Error()))
			return
		}
	}()

	slog.Info("http server started", slog.String("addr", httpServer.Addr))
	slog.Info("press Ctrl+C to shutdown")

	sigChan := make(chan os.Signal, 1)
	signal.Notify(sigChan, syscall.SIGINT, syscall.SIGTERM)

	slog.Info("shutdown signal received", slog.Any("signal", <-sigChan))
	slog.Info("shutting down http server")

	ctx, cancel := context.WithTimeout(c.Context, 5*time.Second)
	defer cancel()

	if err := httpServer.Shutdown(ctx); err != nil {
		slog.Error("failed to shutdown http server", slog.String("error", err.Error()))
		return err
	}
	slog.Info("http server shutdown complete")
	return nil
}
