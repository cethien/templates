package main

import "os"

var (
	msg = func() string {
		if val, ok := os.LookupEnv("MSG"); ok {
			return val
		}
		return "Hello, world!"
	}()
)
