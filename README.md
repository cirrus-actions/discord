# Discord  

Discord webhook system with GitHub Actions. 

[![Cirrus CI Build Status](https://api.cirrus-ci.com/github/cirrus-actions/discord.svg?branch=master)](https://cirrus-ci.com)

## Using  

This is a simple GitHub action that allows to send signals to Discord Webhooks when a GitHub Check Suite completes. This requires a secret environment variable:  
`WEBHOOK_URL` - The Webhook to send the info to.  

## Example  

This example `main.workflow` file works:

```
workflow "Discord" {
  on = "check_suite"
  resolves = "Discord Webhook"
}

action "Discord Webhook" {
  uses = "docker://cirrusactions/discord:latest"
  secrets = ["WEBHOOK_URL"]
}
```

## FAQ

Q: Help! Webhooks aren't being sent and I don't see the action running!  
A: Have you signed up for the actions beta?  It is required to use this.  

Q: How easy is it to set this up?  
A: Very! Just add your `main.workflow`, set up a new webhook in Discord, and watch the magic happen!  
