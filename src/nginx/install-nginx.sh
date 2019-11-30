
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
  runCmd "brew install nginx" 
  runCmd "brew services start nginx" 
  runCmd "brew services enable nginx" 
  runCmd "brew services restart nginx" 
elif [ "$OS" == "Linux" ]; then
  yum --version
  rc=$?
  if [ $rc .eq 0 ]; then
    YUM="sudo yum -y"
    $YUM update
    $YUM install epel-release
    $YUM install nginx
    $YUM enable nginx
    $YUM restart nginx
  else
    GET="sudo apt-get -y"
    $GET update
    $GET upgrade
    $GET install nginx
    $GET enable nginx
    $GET restart nginx
  fi
fi 



 
