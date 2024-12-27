package root

import (
	_ "embed"
)

type meta struct {
	name      string
	version   string
}

func (m *meta) Name() string {
	return m.name
}

func (m *meta) Version() string {
	return m.version
}

//go:embed .version
var version string

var m = &meta{
	version:   version,
}

func Meta() *meta {
	return m
}