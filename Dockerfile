FROM alpine:3.6
MAINTAINER Yaroslav Isakov <yaroslav.isakov@gmail.com>

# Install samba
RUN apk add --no-cache samba samba-common-tools tdb procps bash &&\
    adduser -h /tmp -H -S smbuser && rm -rf /tmp/*

COPY samba.sh /usr/bin/
COPY smb.conf /etc/samba

VOLUME ["/etc/samba"]

EXPOSE 137/udp 138/udp 139 445

ENTRYPOINT ["samba.sh"]

HEALTHCHECK CMD (nc -zv localhost 445) || exit 1
