FROM alpine:latest

MAINTAINER Nguyen Tuan Giang "https://github.com/ntuangiang"

ENV NOTVISIBLE "in users profile"

RUN apk add --no-cache rsync coreutils openssh openssh-client

RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

RUN echo "export VISIBLE=now" >> /etc/profile

COPY rootfs /

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]
