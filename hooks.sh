#!/bin/bash
# Copyright (c) 2019-present CirrusLabs
set -e

# check if it passed or not
if [[ "$(jq -r ".check_suite.conclusion" "$GITHUB_EVENT_PATH")" == "success" ]]; then
  STATUS_MESSAGE="Check suite passing!"
  EMBED_COLOR=3066993
else
  STATUS_MESSAGE="Check suite failing or unknown."
  EMBED_COLOR=15158332
fi

# Webhook data:
WEBHOOK_DATA='{
  "username": "GitHub Actions",
  "avatar_url": "https://avatars1.githubusercontent.com/u/29414678?v=4",
  "embeds": [ {
    "color": '$EMBED_COLOR',
    "author": {
      "name": "Check Suite triggered by '"$GITHUB_ACTOR"'",
      "url": "https://github.com/'$GITHUB_REPOSITORY'",
      "icon_url": "https://avatars1.githubusercontent.com/u/29414678?v=4"
    },
    "title": "View Repository",
    "url": "https://github.com/'$GITHUB_REPOSITORY'",
    "description": "Check Suite Info:",
    "fields": [
      {
        "name": "Commit",
        "value": "'"$GITHUB_SHA"'",
        "inline": true
      },
      {
        "name": "Author",
        "value": "'"[\`$GITHUB_ACTOR\`](https://github.com/$GITHUB_ACTOR)"'",
        "inline": false
      }
    ],
    "timestamp": ""
  } ]
}'

curl --fail -A "Actions-Webhook" -H Content-Type:application/json -d "$WEBHOOK_DATA" "$WEBHOOK_URL"
