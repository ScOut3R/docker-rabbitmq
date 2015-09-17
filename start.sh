#!/bin/bash

ulimit -n 10240
if [ ! -d "/data" ]; then
  mkdir /data
fi
chown -R rabbitmq:rabbitmq /data

if [ $ECOOKIE ]; then
  echo $ECOOKIE > /var/lib/rabbitmq/.erlang.cookie;
  chown rabbitmq:rabbitmq /var/lib/rabbitmq/.erlang.cookie;
  chmod 400 /var/lib/rabbitmq/.erlang.cookie;
fi

if [ -z "$CLUSTERED" ]; then
  exec rabbitmq-server $@
else
    sleep 10 # for kubernetes svc to set endpoint
  if [ -z "$CLUSTER_WITH" ]; then
    exec rabbitmq-server $@
  else
    rabbitmq-server -detached
    rabbitmqctl stop_app
    rabbitmqctl join_cluster rabbit@$CLUSTER_WITH
    rabbitmqctl start_app
    tail -f /data/log/rabbit\@$(hostname -s).log
  fi
fi
