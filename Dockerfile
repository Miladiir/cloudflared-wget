FROM busybox:1.37.0-glibc@sha256:75ad89b4d27ba9abc38d495d4a89969b97ad47fd25b2f8eb959901dad09289f7 as busybox

LABEL org.opencontainers.image.source = "https://github.com/Miladiir/cloudflared-wget"

COPY --from=cloudflare/cloudflared:latest@sha256:6e2df069aaf5a8c0bf304b674ff31c0ed07c974534b4303a8c6e57d93c6c9224 /usr/local/bin/cloudflared /bin
COPY ./docker-healthcheck.sh /bin

ENV TUNNEL_METRICS=127.0.0.1:1337
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD [ "/bin/docker-healthcheck.sh" ]
ENTRYPOINT ["cloudflared", "--no-autoupdate"]
CMD ["version"]
