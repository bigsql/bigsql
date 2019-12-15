source env.sh

c_name=$1
c_port=$2

sudo docker run -d -p $c_port:5432 --name $c_name $base_image
