#!/bin/bash
# Copyright (c) 2019-present CirrusLabs

# Setup Git stuff:
git remote set-url origin https://x-access-token:$GITHUB_TOKEN@github.com/$REPO_FULLNAME.git
git config --global user.email "action@github.com"
git config --global user.name "GitHub Action"

# Build passed:
EMBED_COLOR=3066993
STATUS_MESSAGE="Build Passed"

# Credits (not author, just leftover from port):
CREDITS="This was newly committed."

# Cirrus CI Logo:
LOGO_URL="https://avatars1.githubusercontent.com/u/29414678?v=4"

# Check if variable is null
if [ -z "$WEBHOOK_URL" ]; then
  echo -e "WARNING!!\nYou need to put WEBHOOK_URL as am environment variable!" && exit
fi

# Test to see if this is a pull request:
if [[ $CIRRUS_BRANCH != 'master' ]]; then
  URL="https://github.com/$CIRRUS_REPO_FULL_NAME/pull/$CIRRUS_PR"
else
  URL="https://github.com/$CIRRUS_REPO_FULL_NAME"
fi

# Webhook data:
WEBHOOK_DATA='{
  "username": "Cirrus CI",
  "avatar_url": '$LOGO_URL',
  "embeds": [ {
    "color": '$EMBED_COLOR',
    "author": {
      "name": "Job #'"$CIRRUS_BUILD_ID"' (Task ID: #'"$CIRRUS_TASK_ID"') - '"$CIRRUS_REPO_FULL_NAME"'",
      "url": "'"$CIRRUS_WORKING_DIR"'",
      "icon_url": "'$LOGO_URL'"
    },
    "title": "'"$CIRRUS_CHANGE_MESSAGE"'",
    "url": "'"$URL"'",
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

(curl --fail --progress-bar -A "Cirrus-CI-Webhook" -H Content-Type:application/json -H X-Author:jumbocakeyumyum#0001 -d "$WEBHOOK_DATA" "$WEBHOOK_URL" \
  && echo -e "\\n[Webhook]: Successfully sent the webhook.") || echo -e "\\n[Webhook]: Unable to send webhook (failed)."
