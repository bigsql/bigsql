source env.sh

if [ $# -eq 2 ]; then
  c_name=$1
  c_port=$2
else
  echo "Must be 2 parms; c_name & c_port"
  exit 1
fi

sudo docker run -d -p $c_port:5432 --name $c_name $baseImage
