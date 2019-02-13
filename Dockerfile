FROM alpine:latest
# Metadata:
LABEL version="1.0.0" \
      repository="https://github.com/cirrus-actions/discord" \
      homepage="https://github.com/cirrus-actions/discord" \
      maintainer="Cirrus Labs" \
      "com.github.actions.name"="Discord Webhook" \
      "com.github.actions.description"="Sends if a check suite passed to a Discord webhook" \
      "com.github.actions.icon"="cloud" \
      "com.github.actions.color"="purple"
# Add needed programs via APK:
RUN apk --no-cache add jq bash curl
# Add hooks.sh as an entrypoint:
ADD hooks.sh /hooks.sh
ENTRYPOINT ["/hooks.sh"]
# Make hooks.sh able to be executed
RUN chmod +x /hooks.sh
