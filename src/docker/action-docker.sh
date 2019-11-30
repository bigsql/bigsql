action="$1"
comp="docker"
OS=`uname`
RC=0

function runCmd () {
  echo "#"
  echo "# $1"
  $1
  RC=$?
}

if [ "$OS" == "Darwin" ]; then
  runCmd "brew services $action $comp"
else
  runCmd "sudo systemctl $action $comp"
fi

exit $RC
