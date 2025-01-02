//go:build dev
// +build dev

package main

import (
	_ "github.com/joho/godotenv/autoload"
)

var (
	DefaultMessage = "Hello, world! [DEV]"
	DefaultHTTPPort = 8080
)
