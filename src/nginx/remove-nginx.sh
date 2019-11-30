
OS=`uname`

function runCmd () {
  echo "$1"
  $1
  RC=$?
}

if [ "$OS" == "Darwin" ]; then
  runCmd "brew remove nginx" 
  exit $RC
fi

yum --version 2>&1
RC=$?
if [ $RC .eq 0 ]; then
  runCmd "sudo yum -y remove nginx"
else
  runCmd "sudo apt-get -y remove nginx"
fi

exit $RC
