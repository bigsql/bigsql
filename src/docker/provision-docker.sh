
action="$1"
comp=docker
OS=`uname`
RC=0

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
  brew --version 2>/dev/null 1>/dev/null
  RC=$?

  if [ "$RC" == "0" ]; then
    runCmd "brew $action $comp" 
  else
    echo "ERROR: You must install brew first (http://brew.sh)"
  fi
  
  exit $RC
fi

yum --version 2>/dev/null 1>/dev/null
rc=$?
if [ $rc .eq 0 ]; then
  YUM="sudo yum -y"
  runCmd "$YUM update"
  runCmd "$YUM install epel-release"
  runCmd "$YUM $action $comp"
else
  GET="sudo apt-get -y"
  runCmd "$GET update"
  runCmd "$GET upgrade"
  runCmd "$GET $action $comp"
fi

if [ "$action" == "install" ]; then
  runCmd "sudo systemctl enable $comp"
fi

exit $RC

