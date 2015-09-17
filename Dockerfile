FROM ubuntu:14.04

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 056E8E56
RUN echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y rabbitmq-server
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN rabbitmq-plugins enable rabbitmq_management
COPY rabbitmq.config /etc/rabbitmq/rabbitmq.config

COPY start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 5672
EXPOSE 15672

ENV RABBITMQ_LOG_BASE /data/log
ENV RABBITMQ_MNESIA_BASE /data/mnesia

WORKDIR /data
CMD ["/usr/local/bin/start.sh"]
