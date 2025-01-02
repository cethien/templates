package handler

import (
	"net/http"

	"github.com/labstack/echo/v4"
)

func init() {
	handler.GET("/", indexHandler)
}

func indexHandler(c echo.Context) error {
	return c.String(http.StatusOK, "Hello, world!")
}
