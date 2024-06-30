FROM busybox:1.36.1-glibc@sha256:25e9fcbd3799fce9c0ec978303d35dbb18a6ffb1fc76fc9b181dd4e657e2cd13 as busybox

LABEL org.opencontainers.image.source = "https://github.com/Miladiir/cloudflared-wget"

COPY --from=cloudflare/cloudflared:latest@sha256:b809ea110a98112b0ed98b7d976e373c70321541f1a8f592e7932dd63cbf6c5a /usr/local/bin/cloudflared /bin
COPY ./docker-healthcheck.sh /bin

ENTRYPOINT ["cloudflared", "--no-autoupdate"]
CMD ["version"]