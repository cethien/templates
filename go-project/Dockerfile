FROM alpine:latest as runner
WORKDIR /root/
COPY go-project /usr/bin/
ENTRYPOINT go-project

ENV HTTP_PORT=80
ENV DATABASE_PATH=data/database.db
EXPOSE ${HTTP_PORT}
