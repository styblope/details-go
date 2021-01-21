.PHONY: all build run clean build-podman run-podman clean-all

all: build

build:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags "-s" -o details-go
run:
	go run details.go 9080

clean: clean-podman
	-rm details-go

build-podman: build
	podman build --squash-all -t examples-bookinfo-details-go-v1 .

build-podman-with-builder:
	podman build --squash-all -t examples-bookinfo-details-go-v1 -f Dockerfile.builder .

run-podman: build-podman
	podman run --rm --name details-go -p 9080:9080/tcp examples-bookinfo-details-go-v1

clean-podman:
	-podman rmi examples-bookinfo-details-go-v1

