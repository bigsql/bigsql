source env.sh 

echo "########## Build POSIX Sandbox ##########"

outp="out/posix"

if [ -d $outp ]; then
  echo "Removing current '$outp' directory..."
  $outp/$api stop
  sleep 2
  rm -rf $outp
fi

./build.sh -X posix -R

cd $outp

./$api set GLOBAL REPO http://localhost:8000

./$api --version

./$api info

if [ ! "$1" == "" ]; then
  ./$api info
  ./$api install pg$1; ./$api start pg$1 -y
fi

