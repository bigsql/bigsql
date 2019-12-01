#!/bin/bash

start_dir="$PWD"

# resolve links - $0 may be a softlink
this="${BASH_SOURCE-$0}"
common_bin=$(cd -P -- "$(dirname -- "$this")" && pwd -P)
script="$(basename -- "$this")"
this="$common_bin/$script"
# convert relative path to absolute path
config_bin=`dirname "$this"`
script=`basename "$this"`
my_home=`cd "$config_bin"; pwd`

export MY_HOME="$my_home"
export MY_LOGS="$my_home/test_log.out"

cd "$MY_HOME"

declare -a array
array[0]="$MY_HOME"
array[1]="$MY_HOME/lib"

export PYTHONPATH=$(printf "%s:${PYTHONPATH}" ${array[@]})

pydir="$MY_HOME/python37"
if [ -d "$pydir" ]; then
  export PYTHON="$pydir/python"		
  export PATH="$pydir/bin:$PATH"
  if [ `uname` == "Darwin" ]; then
    export DYLD_LIBRARY_PATH="$pydir/lib/python2.7:$DYLD_LIBRARY_PATH"
  else
    export LD_LIBRARY_PATH="$pydir/lib/python2.7:$LD_LIBRARY_PATH"
  fi
else
 export PYTHON="python3.7"
 pyver=`python3.7 --version  > /dev/null 2>&1`
 rc=$?
 if [ ! $rc == 0 ];then
   pyver=`python3 --version > /dev/null 2>&1`
   rc=$?   
   if [ ! $rc == 0 ];then
     export PYTHON=python
     pyver=`python --version > /dev/null 2>&1`
     rc=$?   
     if [ ! $rc == 0 ];then
       export PYTHON=python2
     else
       export PYTHON=python2
     fi
   else
     export PYTHON=python3
   fi
 fi
fi

mkdir -p conf
cp $DPG/src/conf/db_local.db conf/.
cp $DPG/src/conf/versions.sql conf/.
sqlite3 conf/db_local.db < conf/versions.sql

$PYTHON -u "$MY_HOME/lts.py" "$@"
