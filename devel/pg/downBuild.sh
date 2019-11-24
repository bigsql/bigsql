v96=9.6.16
v10=10.11
v11=11.6
v12=12.1

fatalError () {
  echo "FATAL ERROR!  $1"
  if [ "$2" == "u" ]; then
    printUsageMessage
  fi
  echo
  exit 1
}


echoCmd () {
  echo "# $1"
  checkCmd "$1"
}


checkCmd () {
  $1
  rc=`echo $?`
  if [ ! "$rc" == "0" ]; then
    fatalError "Stopping Script"
  fi
}


downBuild () {
  echo " "
  echo "##################### PostgreSQL $1 ###########################"
  echoCmd "rm -rf *$1*"
  echoCmd "wget https://ftp.postgresql.org/pub/source/v$1/postgresql-$1.tar.gz"
  
  if [ ! -d src ]; then
    mkdir src
  fi
  echoCmd "cp postgresql-$1.tar.gz src/."

  echoCmd "tar -xf postgresql-$1.tar.gz"
  echoCmd "mv postgresql-$1 $1"
  echoCmd "rm postgresql-$1.tar.gz"
  echoCmd "cd $1"
  echoCmd "./configure --prefix=$PWD --with-openssl $options"
  echoCmd "make -j5"
  echoCmd "make install"
  echoCmd "cd .."
}


#################################################################################
##                        MAINLINE
#################################################################################
if [ "$1" == "96" ]; then
  options=""
  downBuild $v96
elif [ "$1" == "10" ]; then
  options=""
  downBuild $v10
elif [ "$1" == "11" ]; then
  options="--with-llvm"
  downBuild $v11
elif [ "$1" == "12" ]; then
  options="--with-llvm"
  downBuild $v12
else
  echo "ERROR: Incorrect PG version.  Must be 96, 10, 11 or 12"
  exit 1
fi
 
