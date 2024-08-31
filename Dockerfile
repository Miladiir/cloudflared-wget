FROM busybox:1.36.1-glibc@sha256:3289bb3bffbac896ee73626c836d711b8b998552f36d56b9dff498ba472a8ecb as busybox

LABEL org.opencontainers.image.source = "https://github.com/Miladiir/cloudflared-wget"

COPY --from=cloudflare/cloudflared:latest@sha256:14d9c6b01b29d556569446b0cc5c9162dc129a92ce127afe27c3aae4534f8af1 /usr/local/bin/cloudflared /bin
COPY ./docker-healthcheck.sh /bin

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD [ "/bin/docker-healthcheck.sh" ]
ENTRYPOINT ["cloudflared", "--no-autoupdate"]
CMD ["version"]