.PHONY: all build run clean build-podman run-podman clean-all

all: build-static build-podman

build:
	go build -o details-go

build-static:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags "-s" -o details-go

run: build-podman
	go run details.go 9080

clean: clean-podman
	-rm details-go

build-podman: build-static
	podman build --squash-all -t examples-bookinfo-details-go-v1 .

run-podman: build-podman
	podman run --rm --name details-go -p 9080:9080/tcp examples-bookinfo-details-go-v1

clean-podman:
	-podman rmi examples-bookinfo-details-go-v1

