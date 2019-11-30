
OS=`uname`
RC=0

function runCmd () {
  echo "$1"
  $1
  RC=$?
}

if [ "$OS" == "Darwin" ]; then
  runCmd "brew services start nginx" 
else
  runCmd "sudo systemctl start ngnix"
fi

exit $RC



 
