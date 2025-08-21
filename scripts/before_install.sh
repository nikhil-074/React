#!/usr/bin/env bash
set -euo pipefail

PROJECT="site1"
APP_DIR="/var/www/$PROJECT"
TMP_DIR="$APP_DIR/tmp"

echo "[BeforeInstall] Preparing directories for $PROJECT..."

# Clean old tmp build (CodeDeploy will copy new build here)
rm -rf "$TMP_DIR/build" || true
mkdir -p "$TMP_DIR"

# Ensure project directories exist
mkdir -p "$APP_DIR/releases"
mkdir -p "$APP_DIR/shared"

# Set ownership & permissions so project user can work with files
chown -R $PROJECT:$PROJECT "$APP_DIR"
chmod -R 755 "$APP_DIR"

echo "[BeforeInstall] Directories ready."
