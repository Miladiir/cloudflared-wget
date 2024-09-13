FROM busybox:1.36.1-glibc@sha256:949757861bcee7514f64d9b44d3c1d43c21f5183cae113e97b98261fc1c522dc as busybox

LABEL org.opencontainers.image.source = "https://github.com/Miladiir/cloudflared-wget"

COPY --from=cloudflare/cloudflared:latest@sha256:0b88e00d8f93f9d18197f11506f0f6bf0d9266b5a0361c068930a3fe45b68b72 /usr/local/bin/cloudflared /bin
COPY ./docker-healthcheck.sh /bin

ENV TUNNEL_METRICS=127.0.0.1:1337
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD [ "/bin/docker-healthcheck.sh" ]
ENTRYPOINT ["cloudflared", "--no-autoupdate"]
CMD ["version"]
