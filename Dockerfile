FROM alpine:3.14

RUN apk update && apk upgrade
RUN apk add --no-cache curl bash fuse

RUN curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip &&\
  unzip rclone-current-linux-amd64.zip &&\
  rm rclone-current-linux-amd64.zip &&\
  cd rclone-*-linux-amd64 &&\
  mv rclone /usr/bin/ &&\
  chown root:root /usr/bin/rclone &&\
  chmod 755 /usr/bin/rclone &&\
  mkdir -p /usr/share/man/man1 &&\
  mv rclone.1 /usr/share/man/man1/ &&\
  cd .. &&\
  rm -rf rclone-v1.61.1-linux-amd64

### Rclone arg/env varables

ARG RCLONE_CONF="/root/.config/rclone/rclone.conf"
ENV RCLONE_CONF="/root/.config/rclone/rclone.conf"

RUN mkdir -p $(dirname $RCLONE_CONF) && touch $RCLONE_CONF

#[BackBlaze]
#type = b2

ARG B2_ACCOUNT=${B2_ACCOUNT}
ENV B2_ACCOUNT=${B2_ACCOUNT}
ARG B2_KEY=${B2_KEY}
ENV B2_KEY=${B2_KEY}

RUN mkdir -p "${RCLONE_CONF%/*}" && touch "$RCLONE_CONF"

RUN echo $B2_ACCOUNT
RUN echo $B2_KEY
RUN mkdir b2

ADD start.sh /app/start.sh

CMD ["bash", "/app/start.sh"]
