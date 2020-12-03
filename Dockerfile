FROM scratch

COPY details-go /opt/microservices/

ARG service_version
ENV SERVICE_VERSION ${service_version:-v1}
ARG enable_external_book_service
ENV ENABLE_EXTERNAL_BOOK_SERVICE ${enable_external_book_service:-false}

EXPOSE 9080

CMD ["/opt/microservices/details-go", "9080"]
