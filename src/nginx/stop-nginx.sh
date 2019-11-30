
OS=`uname`
RC=0

function runCmd () {
  echo "$1"
  $1
  RC=$?
}

if [ "$OS" == "Darwin" ]; then
  runCmd "brew services stop nginx" 
else
  runCmd "sudo systemctl stop ngnix"
fi

exit $RC



 
