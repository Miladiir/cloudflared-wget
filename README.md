Docker Healthcheck ready cloudflared
===

I didnt get the HEALTHCHECK instruction in the Dockerfile to work for some reason. An example on how to implement the actual healthcheck is included in the docker-compose.yml.

Things to note:
- Rebuild as soon as upstream pushes new changes.
- I don't provide semver since it would be a hassle to track cloudflares versioning (yyyy-mm-patch). Grab :latest and pin the image version with sha hash for poor mans versioning.

