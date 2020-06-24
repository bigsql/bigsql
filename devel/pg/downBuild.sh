
v94=9.4.26
v95=9.5.22
v96=9.6.18
v10=10.13
v11=11.8
v12=12.3
v13=13beta1

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


masterBuild () {
  echoCmd "cd 13devel"
  echoCmd "git checkout master"
  echoCmd "git pull"
  makeInstall
  echoCmd "cd .."
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
  makeInstall
  echoCmd "cd .."
}


makeInstall () {
  #echoCmd "make clean"
  #sleep 3
  echoCmd "./configure --prefix=$PWD --with-libedit-preferred --with-python PYTHON=/usr/bin/python3 $options"
  sleep 3
  echoCmd "make -j8"
  sleep 3
  echoCmd "make install"
}


## MAINLINE ##############################

if [ "$1" == "94" ]; then
  options=""
  downBuild $v94
elif [ "$1" == "95" ]; then
  options=""
  downBuild $v95
elif [ "$1" == "96" ]; then
  options=""
  downBuild $v96
elif [ "$1" == "10" ]; then
  options=""
  downBuild $v10
elif [ "$1" == "11" ]; then
  options=""
  downBuild $v11
elif [ "$1" == "12" ]; then
  options="--without-llvm"
  downBuild $v12
elif [ "$1" == "13" ]; then
  options=""
  masterBuild
else
  echo "ERROR: Incorrect PG version.  Must be between 94 and 13"
  exit 1
fi
 
