FROM busybox:1.37.0-glibc@sha256:c598938e58d0efcc5a01efe9059d113f22970914e05e39ab2a597a10f9db9bdc as busybox

LABEL org.opencontainers.image.source = "https://github.com/Miladiir/cloudflared-wget"

COPY --from=cloudflare/cloudflared:latest@sha256:cb38f3f30910a7d51545118a179b8516eb7066eac61855d62ce6ed733c54ce70 /usr/local/bin/cloudflared /bin
COPY ./docker-healthcheck.sh /bin

ENV TUNNEL_METRICS=127.0.0.1:1337
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD [ "/bin/docker-healthcheck.sh" ]
ENTRYPOINT ["cloudflared", "--no-autoupdate"]
CMD ["version"]
