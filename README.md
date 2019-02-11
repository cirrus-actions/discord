# Discord  

Discord webhook system with GitHub Actions. 

[![Cirrus CI Build Status](https://api.cirrus-ci.com/github/cirrus-actions/discord.svg?branch=master)](https://cirrus-ci.com)

## Using  

Right now the project is not complete and is still in prototype phases.  
This is a simple GitHub action that allows to send signals to Discord Webhooks when a GitHub Check Suite completes. This requires a secret environment variable:  
`WEBHOOK_URL` - The Webhook to send the info to.  

## Example  

This example `main.workflow` will work once we are finished:
```
workflow "Discord Webhook" {
  on = "check_suite"
  resolves = "Hook"
}

action "Hook" {
  uses = "docker://the-docker-image"
  secrets = ["WEBHOOK_URL"]
}
```

**WIP!!**
