FROM alpine:3.7
LABEL maintainer "Philip Lawall <philiplawall@gmail.com>"

RUN set -x \
    && apk add --no-cache ca-certificates curl ffmpeg python \
    && curl -Lo /usr/local/bin/youtube-dl https://yt-dl.org/downloads/latest/youtube-dl \
    && chmod a+rx /usr/local/bin/youtube-dl \
    && youtube-dl --version

VOLUME /config /downloads

# Configure cron
COPY crontab /etc/cron/crontab

# Init cron
RUN crontab /etc/cron/crontab

CMD ["crond", "-f"]
