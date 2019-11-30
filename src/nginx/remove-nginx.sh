
OS=`uname`
if [ ! "$OS" == "Darwin" ] && [ ! "$OS" == "$Linux" ]; then
  echo "ERROR: OS must be 'Linux' or 'OSX'"
  exit 1
fi

function runCmd () {
  echo "$1"
  $1
  rc=$?
}

if [ "$OS" == "Darwin" ]; then
  runCmd "brew remove nginx" 
elif [ "$OS" == "Linux" ]; then
  yum --version
  rc=$?
  if [ $rc .eq 0 ]; then
    YUM="sudo yum -y"
    $YUM remove nginx
  else
    GET="sudo apt-get -y"
    $GET remove nginx
  fi
fi 
