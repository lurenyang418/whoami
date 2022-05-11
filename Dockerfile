FROM lurenyang/alpine-golang as builder

ARG NAME=whoami

ENV PATH=/usr/local/go/bin:$PATH

RUN set -eux \
    && apk --no-cache --no-progress add upx\
    && rm -rf /var/cache/apk/*

WORKDIR /whoami

COPY . .

RUN set -eux \
    && CGO_ENABLED=0 go build -a --trimpath --ldflags="-s -w" -o ${NAME} \
    && upx -9 -q ${NAME}

FROM scratch

COPY --from=builder /whoami/whoami .

ENTRYPOINT ["/whoami"]
EXPOSE 7080