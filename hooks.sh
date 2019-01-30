#!/bin/bash
# Copyright (c) 2019-present CirrusLabs

# Setup Git stuff:
git config --global user.email "action@github.com"
git config --global user.name "GitHub Action"
git remote set-url origin https://x-access-token:$GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY.git

# Build passed:
EMBED_COLOR=3066993
STATUS_MESSAGE="Build Passed"

# Credits (not author, just leftover from port):
CREDITS="This was newly committed."

# Cirrus CI Logo:
LOGO_URL="https://avatars1.githubusercontent.com/u/29414678?v=4"

# Check if variable is null
if [ -z "$WEBHOOK_URL" ]; then
  echo -e "WARNING!!\nYou need to pass WEBHOOK_URL to the action!!" && exit
fi

# Webhook data:
WEBHOOK_DATA='{
  "username": "Cirrus CI",
  "avatar_url": '$LOGO_URL',
  "embeds": [ {
    "color": '$EMBED_COLOR',
    "author": {
      "name": "Job Triggered by: #'"$GITHUB_ACTOR"' in '"$GITHUB_REPOSITORY"'",
      "url": "'"$CIRRUS_WORKING_DIR"'",
      "icon_url": "'$LOGO_URL'"
    },
    "title": "'"$CIRRUS_CHANGE_MESSAGE"'",
    "url": "https://github.com/'$GITHUB_REPOSITORY'",
    "description": "'"${CIRRUS_CHANGE_MESSAGE//$'\n'/ }"\\n\\n"$CREDITS"'",
    "fields": [
      {
        "name": "Commit",
        "value": "", # todo: add value
        "inline": true
      },
      {
        "name": "Branch",
        "value": "'"[\`$CIRRUS_BRANCH\`](https://github.com/$CIRRUS_REPO_FULL_NAME/tree/$CIRRUS_BRANCH)"'",
        "inline": true
      }
    ],
    "timestamp": ""
  } ]
}'

# Log that we will now try to send the Webhook:
echo -e "[Webhook]: Sending webhook to Discord...\\n";

(curl --fail --progress-bar -A "Cirrus-CI-Webhook" -H Content-Type:application/json -H X-Author:jumbocakeyumyum#0001 -d "$WEBHOOK_DATA" "$WEBHOOK_URL" \
  && echo -e "\\n[Webhook]: Successfully sent the webhook.") || echo -e "\\n[Webhook]: Unable to send webhook (failed)."
