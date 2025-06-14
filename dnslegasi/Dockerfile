
FROM alpine

RUN apk add --no-cache supervisor bind-tools iptables sniproxy dnsmasq

ADD instl /usr/local/bin/
RUN mkdir -p /opt/dnslegasi

ADD dnsmasq.sh sniproxy.sh domains dnslegasi /opt/dnslegasi/

ADD services.ini /etc/supervisor.d/
ADD my_init /

RUN chmod +x /opt/dnslegasi/dnsmasq.sh
RUN chmod +x /opt/dnslegasi/sniproxy.sh
RUN chmod +x my_init

CMD ["/my_init"]
