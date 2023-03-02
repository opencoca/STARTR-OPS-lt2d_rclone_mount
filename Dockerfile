FROM alpine:3.14
RUN apk add --no-cache curl makewhatis
#RCLONE for Apline currently installer broken on alpine
#RUN curl https://rclone.org/install.sh

RUN curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip
RUN unzip rclone-current-linux-amd64.zip
RUN cd rclone-*-linux-amd64 &&\
  cp rclone /usr/bin/ &&\
  chown root:root /usr/bin/rclone &&\
  chmod 755 /usr/bin/rclone &&\
  mkdir -p /usr/share/man/man1 &&\
  cp rclone.1 /usr/share/man/man1/ &&\
  makewhatis /usr/share/man

### Rclone arg/env varables
#[sftp]
#type= sftp
#ARG SFTP_HOST = ${SFPT_HOST}
#ENV SFTP_HOST = ${SFPT_HOST}
#ARG SFTP_USER = ${SFTP_USER}
#ENV SFTP_USER = ${SFTP_USER}

#ARG key_file = /app/.ssh/id_rsa
#ENV key_file = /app/.ssh/id_rsa

#ARG md5sum_command = md5sum
#ENV md5sum_command = md5sum
#ARG sha1sum_command = sha1sum
#ENV sha1sum_command = sha1sum

#[BackBlaze]
#type = b2

ARG B2_ACCOUNT=${B2_ACCOUNT}
ENV B2_ACCOUNT=${B2_ACCOUNT}
ARG B2_KEY=${B2_KEY}
ENV B2_KEY=${B2_KEY}

RUN printf '%s\n' \
    '[BackBlaze]' \
    'type = b2' \
    'account = $B2_ACCOUNT' \
    'key = $B2_KEY' \
    '' \ > /root/.config/rclone/rclone.conf

RUN cat /root/.config/rclone/rclone.conf

