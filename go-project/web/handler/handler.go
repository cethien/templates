package handler

import (
	"net/http"

	"github.com/labstack/echo/v4"
)

var handler = echo.New()

func Handler() http.Handler {
	return handler
}
