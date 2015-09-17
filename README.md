# RabbitMQ with Docker

A simple Dockerfiles to build an image for Elasticsearch to be used with Docker. The database files are placed in */data* so you might want to attach a volume there.

## Cluster

You can set the *ECOOKIE*, *CLUSTERED* and *CLUSTERED_WITH* environment variables to create a cluster. The cluster consists of a *master* node and *slave* nodes. The *slaves* are joining to the *master*. You can check the *compose-cluster.yml* file how to configure a cluster. The docker-compose configuration brings up a 3 member cluster.

    # docker-compose -f compose-cluster.yml up
