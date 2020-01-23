
osVersion=$1
baseImage=$2

sudo docker image rm -f $baseImage
sudo docker build --file Dockerfile.$osVersion --tag $baseImage .
