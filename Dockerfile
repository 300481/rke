FROM alpine:latest AS downloader

RUN apk -U --no-cache add ca-certificates wget && \
    VERSION=v1.1.4 && \
    cd /tmp && \
    wget -q https://github.com/rancher/rke/releases/download/${VERSION}/rke_linux-amd64 && \
    mv rke_linux-amd64 rke && \
    chmod 755 /tmp/rke

FROM gcr.io/distroless/static

COPY --from=downloader /tmp/rke /usr/local/sbin/

WORKDIR /rke

ENTRYPOINT [ "/usr/local/sbin/rke" ]
