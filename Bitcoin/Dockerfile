FROM ubuntu:20.04

COPY ./bitcoin-22.0/ /usr/local/etc/bitcoin-22.0
COPY ./bitcoin/ /usr/local/etc/bitcoin

WORKDIR /usr/local/etc
RUN apt update
RUN apt install net-tools
#RUN apt install sysstat
RUN install -m 0755 -o root -g root -t /usr/local/bin bitcoin-22.0/bin/*
WORKDIR /usr/local/etc/bitcoin
RUN chmod 777 /usr/local/etc/bitcoin/*.sh
RUN chmod 777 /usr/local/etc/bitcoin/bitcoin.conf
RUN export PATH=$PATH:/usr/bin
ENTRYPOINT ["/usr/local/etc/bitcoin/start_TRN.sh"]
#ENTRYPOINT ["/usr/local/etc/bitcoin/start_check.sh"]
