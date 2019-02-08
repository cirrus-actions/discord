FROM alpine:latest

LABEL version="0.1.0" \
      repository="https://github.com/cirrus-actions/discord" \
      homepage="https://github.com/cirrus-actions/discord" \
      maintainer="Cirrus Labs" \
      "com.github.actions.name"="Discord Build Webhook" \
      "com.github.actions.description"="Sends if the build passed to a Discord webhook" \
      "com.github.actions.icon"="cloud" \
      "com.github.actions.color"="purple"

RUN apk --no-cache add jq bash curl git

ADD hooks.sh /hooks.sh
ENTRYPOINT ["/hooks.sh"]
