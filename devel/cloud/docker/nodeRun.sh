
if [ $# -eq 3 ]; then
  c_image=$1
  c_name=$2
  c_port=$3
else
  echo "Must be 3 parms; {image_name, container_name, mapped_port"
  exit 1
fi

cmd="sudo docker run -d -p $c_port:5432 --name $c_name $c_image"
echo $cmd
$cmd

