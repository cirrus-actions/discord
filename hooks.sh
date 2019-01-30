#!/bin/bash

# Setup Git stuff:
git remote set-url origin https://x-access-token:$GITHUB_TOKEN@github.com/$REPO_FULLNAME.git
git config --global user.email "action@github.com"
git config --global user.name "GitHub Action"

# Build passed:
EMBED_COLOR=3066993
STATUS_MESSAGE="Passed Without Error"
AVATAR="https://avatars1.githubusercontent.com/u/29414678?v=4" # logo
