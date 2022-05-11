FROM golang:1-alpine as builder

LABEL maintainer="lurenyang@outlook.com"

RUN set -eux \
    && sed -i s#dl-cdn.alpinelinux.org#mirror.tuna.tsinghua.edu.cn#g /etc/apk/repositories \
    && apk --no-cache --no-progress add git tzdata make \
    && rm -rf /var/cache/apk/*

WORKDIR /go/whoami

COPY . .

RUN make build

# Create a minimal container to run a Golang static binary
FROM scratch

COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /go/whoami/whoami .

ENTRYPOINT ["/whoami"]
EXPOSE 7080