#!/bin/bash
# Copyright (c) 2019-present CirrusLabs

# Setup Git stuff:
git config --global user.email "action@github.com"
git config --global user.name "GitHub Action"
git remote set-url origin https://x-access-token:$GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY.git

# check if it passed or not
if [ jq -r ".check_suite.conclusion" "$GITHUB_EVENT_PATH" | grep -Eq "^success$" ]
then
  STATUS_MESSAGE="Check suite passing!"
  EMBED_COLOR=3066993
else
  STATUS_MESSAGE="Check suite failing."
  EMBED_COLOR=15158332
fi

STATUS_MESSAGE="New commit"

# Credits (not author, just leftover from port):
CREDITS="This was newly committed."

# Cirrus CI Logo:
LOGO_URL="https://avatars1.githubusercontent.com/u/29414678?v=4"

# Webhook data:
WEBHOOK_DATA='{
  "username": "GitHub Actions",
  "avatar_url": '$LOGO_URL',
  "embeds": [ {
    "color": '$EMBED_COLOR',
    "author": {
      "name": "Check Suite Triggered by: #'"$GITHUB_ACTOR"' in '"$GITHUB_REPOSITORY"'",
      "url": "https://github.com",
      "icon_url": "'$LOGO_URL'"
    },
    "title": "'"$CREDITS"'",
    "url": "https://github.com/'$GITHUB_REPOSITORY'",
    "description": "'"${GITHUB_SHA//$'\n'/ }"\\n\\n"$CREDITS"'",
    "fields": [
      {
        "name": "Commit",
        "value": "'"$GITHUB_SHA"'",
        "inline": true
      },
      {
        "name": "User",
        "value": "'"[\`$GITHUB_ACTOR\`](https://github.com/$GITHUB_ACTOR)"'",
        "inline": true
      }
    ],
    "timestamp": ""
  } ]
}'

# Send the hook:
curl --fail -A "GitHub-Actions-Webhook" -H Content-Type:application/json -H X-Author:jumbocakeyumyum#0001 -d "$WEBHOOK_DATA" "$WEBHOOK_URL"
