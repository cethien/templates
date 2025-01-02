package web

import (
	"fmt"
	"net/http"

	"example.com/go-project/web/handler"
)

func HTTPServer(port int) *http.Server {
	return &http.Server{
		Addr:    fmt.Sprintf(":%d", port),
		Handler: handler.Handler(),
	}
}
