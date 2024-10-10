FROM busybox:1.37.0-glibc@sha256:6f1b51ce286ec478764ecaef269d9188e71b9fdd1f907670abd38549baf8dabe as busybox

LABEL org.opencontainers.image.source = "https://github.com/Miladiir/cloudflared-wget"

COPY --from=cloudflare/cloudflared:latest@sha256:060f16531b1ed6dcb382cd2b35d1a845f8dbcb445003b9ec48eef0078cb08bf4 /usr/local/bin/cloudflared /bin
COPY ./docker-healthcheck.sh /bin

ENV TUNNEL_METRICS=127.0.0.1:1337
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD [ "/bin/docker-healthcheck.sh" ]
ENTRYPOINT ["cloudflared", "--no-autoupdate"]
CMD ["version"]
