.PHONY: all build run clean build-podman run-podman clean-all

all: build

build:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags "-s" -o details-go
run:
	go run details.go 9080

clean: clean-podman clean-docker
	-rm details-go

build-podman: build
	podman build --squash-all -t examples-bookinfo-details-go-v1 .

build-podman-with-builder:
	podman build --squash-all -t examples-bookinfo-details-go-v1 -f Dockerfile.builder .

run-podman: build-podman
	podman run --rm --name details-go -p 9080:9080/tcp examples-bookinfo-details-go-v1

clean-podman:
	-podman rmi examples-bookinfo-details-go-v1


build-docker: build
	docker build --squash-all -t examples-bookinfo-details-go-v1 .

build-docker-with-builder:
	docker build --squash-all -t examples-bookinfo-details-go-v1 -f Dockerfile.builder .

run-docker: build-docker
	docker run --rm --name details-go -p 9080:9080/tcp examples-bookinfo-details-go-v1

clean-docker:
	-docker rmi examples-bookinfo-details-go-v1

