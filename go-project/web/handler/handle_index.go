package handler

import (
	"net/http"

	"example.com/go-project/store/sqlite"
	"github.com/labstack/echo/v4"
)

func init() {
	handler.GET("/", indexHandler)
}

func indexHandler(c echo.Context) error {
	msg, err := sqlite.Queries().SelectMessage(c.Request().Context())
	if err != nil {
		return err
	}

	return c.String(http.StatusOK, msg)
}
