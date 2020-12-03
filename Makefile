.PHONY: all build run clean build-podman run-podman clean-all

all: build-static build-podman

build:
	go build -o details-go

build-static:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags "-s" -o details-go

run: build-podman
	go run details.go 9080

clean:
	-rm details-go

build-podman: build-static
	podman build --squash-all -t details-go .

run-podman: build-podman
	podman run --rm --name details-go -p 9080:9080/tcp details-go

clean-podman:
	-podman rmi details-go

clean-all: clean-podman clean
