source env.sh 

## optional parms
pgV="$1"
comp="$2"

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

##./$api --version
./$api info

if [ ! "$1" == "" ]; then
  ./$api install pg$pgV; ./$api start pg$pgV -y
  if [ ! "$2" == "" ]; then
    ./$api install $comp
  fi
fi

