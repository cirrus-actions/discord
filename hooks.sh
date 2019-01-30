#!/bin/bash

git remote set-url origin https://x-access-token:$GITHUB_TOKEN@github.com/$REPO_FULLNAME.git
git config --global user.email "action@github.com"
git config --global user.name "GitHub Action"
