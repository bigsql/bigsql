
source env.sh

export PGV=$pgV

sudo docker image rm -f $baseImage
sudo docker build --file Dockerfile.pglogical2.centos7 --build-arg PGV --tag $baseImage .
