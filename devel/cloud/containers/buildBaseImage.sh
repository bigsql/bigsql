
osVersion=cos7
baseImage=base7

docker image rm -f $baseImage
docker build --file Dockerfile.$osVersion --tag $baseImage .
