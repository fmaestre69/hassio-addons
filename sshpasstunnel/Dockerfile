FROM alpine:latest

ENV LANG C.UTF-8

RUN apk add --no-cache bash tzdata jq openssh vim curl autossh sshpass

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
