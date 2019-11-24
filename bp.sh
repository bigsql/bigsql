
echo "########## Build POSIX Sandbox ##########"

outp="out/posix"

if [ -d $outp ]; then
  echo "Removing current '$outp' directory..."
  $outp/apg stop
  sleep 2
  rm -rf $outp
fi

./build.sh -X posix -R

cd $outp

./apg set GLOBAL REPO http://localhost:8000

./apg --version

