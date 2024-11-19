FROM busybox:1.37.0-glibc@sha256:3757a0aac2f46c8f8f96dae75b7f2b633d745252ef9d46bdce9c588a564cfc84 as busybox

LABEL org.opencontainers.image.source = "https://github.com/Miladiir/cloudflared-wget"

COPY --from=cloudflare/cloudflared:latest@sha256:665dda65335e35a782ed9319aa63e8404f88b34d2644d30adf3e91253604ffa0 /usr/local/bin/cloudflared /bin
COPY ./docker-healthcheck.sh /bin

ENV TUNNEL_METRICS=127.0.0.1:1337
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD [ "/bin/docker-healthcheck.sh" ]
ENTRYPOINT ["cloudflared", "--no-autoupdate"]
CMD ["version"]
