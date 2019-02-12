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

CREDITS="This was newly checked."

# Webhook data:
WEBHOOK_DATA='{
  "username": "GitHub Actions",
  "avatar_url": 'https://avatars1.githubusercontent.com/u/29414678?v=4',
  "embeds": [ {
    "color": '$EMBED_COLOR',
    "author": {
      "name": "Check Suite triggered by '"$GITHUB_ACTOR"' in '"$GITHUB_REPOSITORY"'",
      "url": "https://github.com/$GITHUB_REPOSITORY",
      "icon_url": "https://avatars1.githubusercontent.com/u/29414678?v=4"
    },
    "title": "Information:",
    "url": "https://github.com/'$GITHUB_REPOSITORY'",
    "description": "--------------",
    "fields": [
      {
        "name": "Commit",
        "value": "'"$GITHUB_SHA"'",
        "inline": true
      },
      {
        "name": "Author",
        "value": "'"[\`$GITHUB_ACTOR\`](https://github.com/$GITHUB_ACTOR)"'",
        "inline": true
      }
    ],
    "timestamp": ""
  } ]
}'

curl --fail -A "Actions-Webhook" -H Content-Type:application/json -H X-Author:jumbocakeyumyum#0001 -d "$WEBHOOK_DATA" "$WEBHOOK_URL"
