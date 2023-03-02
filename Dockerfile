FROM alpine:3.14

RUN RUN apk update && apk upgrade
RUN apk add --no-cache curl screen 
#RCLONE for Apline currently installer broken on alpine
#RUN curl https://rclone.org/install.sh

RUN curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip
RUN unzip rclone-current-linux-amd64.zip
RUN cd rclone-*-linux-amd64 &&\
  cp rclone /usr/bin/ &&\
  chown root:root /usr/bin/rclone &&\
  chmod 755 /usr/bin/rclone &&\
  mkdir -p /usr/share/man/man1 &&\
  cp rclone.1 /usr/share/man/man1/
  #makewhatis /usr/share/man

### Rclone arg/env varables

ARG RCLONE_CONF="/root/.config/rclone/rclone.conf"
ENV RCLONE_CONF="/root/.config/rclone/rclone.conf"

#[BackBlaze]
#type = b2

ARG B2_ACCOUNT=${B2_ACCOUNT}
ENV B2_ACCOUNT=${B2_ACCOUNT}
ARG B2_KEY=${B2_KEY}
ENV B2_KEY=${B2_KEY}

RUN mkdir -p "${RCLONE_CONF%/*}" && touch "$RCLONE_CONF"

RUN printf '%s\n' \
    '[BackBlaze]' \
    'type = b2' \
    'account = $B2_ACCOUNT' \
    'key = $B2_KEY' \
    '' \ > /root/.config/rclone/rclone.conf

RUN echo $B2_ACCOUNT

RUN echo $B2_KEY

CMD ["cat /root/.config/rclone/rclone.conf & sleep 600"]
