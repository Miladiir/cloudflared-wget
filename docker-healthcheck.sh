#!/bin/sh

# Cloudflared healthcheck, result is minified json.
if /bin/wget -q "$TUNNEL_METRICS" -O - | grep -q '"status":200'; then
  # {"status":200,"readyConnections":4,"connectorId":"someuuid"}
  exit 0
else
  # no response, or status != 200
  exit 1
fi
