FROM alpine:edge

RUN apk --no-cache add dnsmasq sniproxy

COPY root/ /

VOLUME /etc/dnsmasq.d

EXPOSE 53 53/udp 80 443 

ENTRYPOINT ["/startup.sh"]
