#!/bin/bash

CONTAINER_NAME=tanzu-jupyter

# stop container if it's already running
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    docker container stop $CONTAINER_NAME
fi

docker container run --publish 8888:8888 --interactive --tty --rm --detach --volume /Users/johnb:/home/jovyan --name $CONTAINER_NAME fjb4/tanzu-jupyter
sleep 2
docker container logs --tail 10 $CONTAINER_NAME
open http://localhost:8888