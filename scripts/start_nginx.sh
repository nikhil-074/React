#!/usr/bin/env bash
set -euo pipefail

PROJECT="site1"
APP_DIR="/var/www/$PROJECT"
CURRENT="$APP_DIR/current"

echo "[ApplicationStart] Starting Nginx for $PROJECT..."

# Check if current symlink exists and is valid
if [ ! -L "$CURRENT" ] || [ ! -d "$CURRENT" ]; then
  echo "[ERROR] Current release not found at $CURRENT"
  exit 1
fi

# Test nginx config before reload
if ! nginx -t; then
  echo "[ERROR] Nginx configuration test failed. Aborting reload."
  exit 1
fi

# Reload nginx gracefully (no downtime)
systemctl reload nginx

echo "[ApplicationStart] Nginx reloaded successfully for $PROJECT"
