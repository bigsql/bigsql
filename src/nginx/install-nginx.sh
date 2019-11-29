
OS=`uname`
if [ ! "$OS" == "Darwin"] && [ ! "$OS" == "$Linux" ]; then
  echo "ERROR: OS must be 'Linux' or 'OSX'"
  exit 1
fi

if [ "$OS" == "Darwin" ]; then
  brew install nginx
  brew services start nginx
  brew service enable nginx"
  brew service restart nginx"
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



 
