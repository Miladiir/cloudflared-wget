Docker Healthcheck ready cloudflared
===

Use the integrated healthcheck located at /bin/docker-healthcheck.sh to check the metrics /ready endpoint.

This increases image size by a lot unfortunately. I couldn't get busybox wget to work inside the cloudflared image by itself, so I opted to copy the cloudflared binary into busybox instead.
This also increases the attack surface of the container, which is not ideal.

Things to note:
- Rebuild as soon as upstream pushes new changes.
- I don't provide semver since it would be a hassle to track cloudflares versioning (yyyy-mm-patch). Grab :latest and pin the image version with sha hash for poor mans versioning.

