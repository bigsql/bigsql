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
dpg_home=`cd "$config_bin"; pwd`

export DPG_HOME="$dpg_home"
export DPG_LOGS="$dpg_home/logs/dpg_log.out"

cd "$DPG_HOME"

hub_new="$DPG_HOME/hub_new"
if [ -d "$hub_new" ];then
  `mv $DPG_HOME/hub_new $DPG_HOME/hub_upgrade`
  log_time=`date +"%Y-%m-%d %H:%M:%S"`
  echo "$log_time [INFO] : completing hub upgrade" >> $DPG_LOGS
  `mv $DPG_HOME/hub $DPG_HOME/hub_old`
  `cp -rf $DPG_HOME/hub_upgrade/* $DPG_HOME/`
  `rm -rf $DPG_HOME/hub_upgrade`
  `rm -rf $DPG_HOME/hub_old`
  log_time=`date +"%Y-%m-%d %H:%M:%S"`
  echo "$log_time [INFO] : hub upgrade completed" >> $DPG_LOGS
fi

declare -a array
array[0]="$DPG_HOME/hub/scripts"
array[1]="$DPG_HOME/hub/scripts/lib"

export PYTHONPATH=$(printf "%s:${PYTHONPATH}" ${array[@]})

pydir="$DPG_HOME/python37"
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

if [ -f /usr/lib64/perl5/CORE/libperl.so ]; then 
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib64/perl5/CORE 
fi

$PYTHON -u "$DPG_HOME/hub/scripts/dpg.py" "$@"
