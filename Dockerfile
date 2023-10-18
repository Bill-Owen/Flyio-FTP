FROM alpine:3.18.4

RUN apk add --no-cache --update bash vsftpd==3.0.5-r2

COPY ftpserver/vsftpd.conf /etc
COPY ftpserver/start.sh /

ENTRYPOINT ["/bin/bash", "/start.sh"]
