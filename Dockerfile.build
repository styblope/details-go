FROM golang:1.15.5 as builder
WORKDIR /go/src/details-go
COPY details.go .
RUN go get -d ./... \
    && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags "-s" -o details-go

FROM scratch
COPY --from=builder /go/src/details-go/details-go /opt/microservices/
ARG service_version
ENV SERVICE_VERSION ${service_version:-v1}
ARG enable_external_book_service
ENV ENABLE_EXTERNAL_BOOK_SERVICE ${enable_external_book_service:-false}

EXPOSE 9080

CMD ["/opt/microservices/details-go", "9080"]
