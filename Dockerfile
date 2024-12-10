FROM busybox:1.37.0-glibc@sha256:0911a82648a678cf004e61d4ac4e809e087ae22e7fcc6338861d6f6ac8277099 as busybox

LABEL org.opencontainers.image.source = "https://github.com/Miladiir/cloudflared-wget"

COPY --from=cloudflare/cloudflared:latest@sha256:fc6afe4a5dcf2a801b39fcd538c9d5d4d53ea229fe9976584835bdb8c185ed5d /usr/local/bin/cloudflared /bin
COPY ./docker-healthcheck.sh /bin

ENV TUNNEL_METRICS=127.0.0.1:1337
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD [ "/bin/docker-healthcheck.sh" ]
ENTRYPOINT ["cloudflared", "--no-autoupdate"]
CMD ["version"]
