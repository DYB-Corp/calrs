#!/usr/bin/env bash
# Launch the preprod calrs server with the env vars from calrs.env.
# Usage: ./serve.sh            (port 3000, or $CALRS_PORT)
#        ./serve.sh --port 8080
set -euo pipefail
cd "$(dirname "$0")"

# Load calrs.env (SMTP creds, CALRS_BASE_URL, CALRS_ALLOW_PRIVATE_HOSTS, ...).
if [ -f calrs.env ]; then
  set -a
  . ./calrs.env
  set +a
fi

# Default port unless one is passed on the command line.
if [[ "$*" == *--port* ]]; then
  exec ./target/release/calrs serve "$@"
else
  exec ./target/release/calrs serve --port "${CALRS_PORT:-3000}" "$@"
fi
