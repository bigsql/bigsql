
osVersion=$1
baseImage=$2

docker image rm -f $baseImage
docker build --file Dockerfile.$osVersion --tag $baseImage .
