#!/bin/bash
set -e

echo "Removing server.pid"
rm -f /usr/src/app/tmp/pids/server.pid

exec "$@"
