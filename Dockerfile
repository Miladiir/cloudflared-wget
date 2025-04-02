FROM busybox:1.37.0-glibc@sha256:45fb3214fa75ede765da7fa85a18a96d0973c26d84dac49b1af23923e627a219 AS busybox

LABEL org.opencontainers.image.source="https://github.com/Miladiir/cloudflared-wget"

COPY --from=cloudflare/cloudflared:latest@sha256:522827fe6220249d72ade9a85cf5bdcc52c18ef1d13c7a3bb7480f56a0fd36e6 /usr/local/bin/cloudflared /bin
COPY ./docker-healthcheck.sh /bin

ENV TUNNEL_METRICS=127.0.0.1:1337
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD [ "/bin/docker-healthcheck.sh" ]
ENTRYPOINT ["cloudflared", "--no-autoupdate"]
CMD ["version"]
