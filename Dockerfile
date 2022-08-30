FROM golang:alpine as builder

ARG NAME=whoami

WORKDIR /whoami

COPY . .

RUN set -eux \
    && CGO_ENABLED=0 go build -a --trimpath --ldflags="-s -w" -o ${NAME}

FROM scratch

COPY --from=builder /whoami/whoami .

ENTRYPOINT ["/whoami"]
EXPOSE 7080