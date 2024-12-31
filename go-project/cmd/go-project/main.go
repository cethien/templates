package main

import (
	"log/slog"
	"os"
	"os/signal"
	"syscall"
)

func main() {
	slog.Info(msg)

	sigChan := make(chan os.Signal, 1)
	signal.Notify(sigChan, syscall.SIGINT, syscall.SIGTERM)
	<-sigChan

	slog.Info("Shutting down. Bye!")
}
