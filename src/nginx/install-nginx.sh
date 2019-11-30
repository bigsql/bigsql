
OS=`uname`

function runCmd () {
  echo "#"
  echo "# $1"
  $1
  RC=$?
  if [ ! "$RC" == "0" ]; then
    echo "ERROR: rc=$RC"
    exit $RC
  fi
}

if [ "$OS" == "Darwin" ]; then
  brew --version 2>&1
  RC=$?

  if [ "$RC" == "0" ]; then
    runCmd "brew install nginx" 
  else
    echo "ERROR: You must install brew first (http://brew.sh)"
  fi
  
  exit $RC
fi

yum --version 2>&1
rc=$?
if [ $rc .eq 0 ]; then
  YUM="sudo yum -y"
  runCmd "$YUM update"
  runCmd "$YUM install epel-release"
  runCmd "$YUM install nginx"
else
  GET="sudo apt-get -y"
  runCmd "$GET update"
  runCmd "$GET upgrade"
  runCmd "$GET install nginx"
fi

runCmd "sudo systemctl enable nginx"

exit 0

