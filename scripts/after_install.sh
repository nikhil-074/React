#!/usr/bin/env bash
set -euo pipefail

PROJECT="site1"
APP_DIR="/var/www/$PROJECT"
RELEASES="$APP_DIR/releases"
TMP_BUILD="$APP_DIR/tmp/build"

STAMP="${CODEDEPLOY_DEPLOYMENT_ID:-$(date +%Y%m%d%H%M%S)}"
NEW_RELEASE="$RELEASES/$STAMP"

echo "[AfterInstall] Deploying new release $NEW_RELEASE for $PROJECT..."

# Make a new release folder
mkdir -p "$NEW_RELEASE"

# Copy the built React app from tmp to the new release
rsync -a --delete "$TMP_BUILD/" "$NEW_RELEASE/"

# Update the symlink to point to the new release
ln -sfn "$NEW_RELEASE" "$APP_DIR/current"

# Fix permissions (owned by project user)
find "$NEW_RELEASE" -type d -exec chmod 755 {} \;
find "$NEW_RELEASE" -type f -exec chmod 644 {} \;

echo "[AfterInstall] New release ready at $NEW_RELEASE"

