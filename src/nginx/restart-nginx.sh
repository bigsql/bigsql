
OS=`uname`
RC=0

function runCmd () {
  echo "$1"
  $1
  RC=$?
}

if [ "$OS" == "Darwin" ]; then
  runCmd "brew services restart nginx" 
else
  runCmd "sudo systemctl restart ngnix"
fi

exit $RC



 
