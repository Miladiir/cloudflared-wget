FROM busybox:1.37.0-glibc@sha256:c598938e58d0efcc5a01efe9059d113f22970914e05e39ab2a597a10f9db9bdc as busybox

LABEL org.opencontainers.image.source = "https://github.com/Miladiir/cloudflared-wget"

COPY --from=cloudflare/cloudflared:latest@sha256:3247f3ef49eda23244b8aa5583f82b7c3880b0d057e1172d0e818f5e678d9f27 /usr/local/bin/cloudflared /bin
COPY ./docker-healthcheck.sh /bin

ENV TUNNEL_METRICS=127.0.0.1:1337
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD [ "/bin/docker-healthcheck.sh" ]
ENTRYPOINT ["cloudflared", "--no-autoupdate"]
CMD ["version"]
