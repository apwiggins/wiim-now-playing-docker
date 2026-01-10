#!/bin/sh
set -e

echo "WNP version: ${VERSION:-Unknown}"
echo "--------------------------"

# Execute the CMD from Dockerfile
cd /app

if [ "$1" = "" ]; then
    exec CMD node server/index.js
else
    exec "$@"
fi
