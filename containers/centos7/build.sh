
source env.sh

sudo docker build --file Dockerfile.pglogical2.centos7 --build-arg PGV=$pgV --tag $baseImage .
