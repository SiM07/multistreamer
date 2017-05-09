FROM ubuntu:zesty

WORKDIR /opt

COPY install.sh /opt/
COPY sockexec.sh /opt/

RUN apt-get update; apt-get install -y curl supervisor lua5.1 luarocks telnet postgresql-client

RUN ./install.sh
RUN ./sockexec.sh

COPY . /opt/

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8081
EXPOSE 1935
 
CMD ["/usr/bin/supervisord"]
