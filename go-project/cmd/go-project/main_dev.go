//go:build dev
// +build dev

package main

func init() {
	app.DefaultCommand = "serve"
}
