FROM busybox:1.36.1-glibc@sha256:0fcfe38431d903645afa509f1a1109be4e209986986d634767f6744eb5869e22 as busybox

LABEL org.opencontainers.image.source = "https://github.com/Miladiir/cloudflared-wget"

COPY --from=cloudflare/cloudflared:latest@sha256:14d9c6b01b29d556569446b0cc5c9162dc129a92ce127afe27c3aae4534f8af1 /usr/local/bin/cloudflared /bin
COPY ./docker-healthcheck.sh /bin

ENV TUNNEL_METRICS=127.0.0.1:1337
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD [ "/bin/docker-healthcheck.sh" ]
ENTRYPOINT ["cloudflared", "--no-autoupdate"]
CMD ["version"]
