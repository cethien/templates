APP_NAME=go-project
BINARY=tmp/$(APP_NAME)
DEBUG=false

.PHONY: default
default: clean build

.PHONY: clean
clean:
	@rm -rf dist/ tmp/
	@find . -type d -empty -delete

.PHONY: download
download:
	@go mod tidy

.PHONY: update
update:
	@go get -u ./...

.PHONY: build
build:
	@go build -tags='dev' -o $(BINARY) ./cmd/$(APP_NAME)

.PHONY: run
run:
	@\
	bash -c "if [ "$(DEBUG)" = "true" ]; then \
		echo "rebuild"; \
	else \
		$(BINARY); \
	fi"

.PHONY: dev
dev:
	@\
	wgo -file .go go mod tidy :: \
	wgo -file .go make -s build :: \
	wgo -file $(BINARY) make -s run

.PHONY: debug
debug:
	@make DEBUG=true dev

.PHONY: snapshot
snapshot:
	@goreleaser release --snapshot --clean

TAG=v$(shell cat .version)

.PHONY: git-tag
git-tag:
	@git tag -f -a $(TAG) -m "Release $(TAG)"
	@git push origin $(TAG)

.PHONY: push-tag
push-tag:
	@git push origin $(TAG)