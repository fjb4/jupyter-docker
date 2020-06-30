docker container run --publish 8888:8888 --interactive --tty --rm --detach --volume /Users/johnb:/home/jovyan --name tanzu-jupyter fjb4/tanzu-jupyter
sleep 2
docker container logs tanzu-jupyter