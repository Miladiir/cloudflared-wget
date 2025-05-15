FROM busybox:1.37.0-glibc@sha256:47ac99f1ae0afb8d83d8cd8aac5461be8103cac932f2631b5acce9122236adb1 AS busybox

LABEL org.opencontainers.image.source="https://github.com/Miladiir/cloudflared-wget"

COPY --from=cloudflare/cloudflared:latest@sha256:f9d5c5b94cd7337c0c939a6dbf5537db34030828c243fca6b589fd85ab25d43b /usr/local/bin/cloudflared /bin
COPY ./docker-healthcheck.sh /bin

ENV TUNNEL_METRICS=127.0.0.1:1337
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD [ "/bin/docker-healthcheck.sh" ]
ENTRYPOINT ["cloudflared", "--no-autoupdate"]
CMD ["version"]
