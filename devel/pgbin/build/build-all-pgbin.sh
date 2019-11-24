#!/bin/bash
#

pgSrc=$SRC/postgresql
binBld=/opt/pgbin-build/builds
source ./versions.sh


function runPgBin {
  ##echo "#"
  pOutDir=$1
  ##echo "# outDir = $pOutDir"
  pPgSrc=$2
  ##echo "# pPgSrc = $pPgSrc"
  pBldV=$3
  ##echo "#   BldV = $pBldV"

  bncrSrc=$SRC/pgbouncer-$bouncerV.tar.gz
  odbcSrc=$SRC/psqlodbc-$odbcV.tar.gz
  bkrstSrc=$SRC/backrest-$backrestV.tar.gz
 
  cmd="./build-pgbin.sh -a $pOutDir -t $pPgSrc -n $pBldV"
  cmd="$cmd $optional"
  ##echo "# $cmd"
  $cmd
  if [[ $? -ne 0 ]]; then
    echo "Build Failed"
    exit 1	
  fi

  return
}

########################################################################
##                     MAINLINE                                       ##
########################################################################

## validate input parm
majorV="$1"
if [ "$majorV" == "10" ]; then
  pgV=$pg10V
  pgBuildV=$pg10BuildV
elif [ "$majorV" == "11" ]; then
  pgV=$pg11V
  pgBuildV=$pg11BuildV
elif [ "$majorV" == "12" ]; then
  pgV=$pg12V
  pgBuildV=$pg12BuildV
elif [ "$majorV" == "all" ]; then
  echo "Hello ALL"
else
  echo "ERROR: must supply pg version of 10, 11, 12 or all"
  exit 1
fi
optional="$2"

shared_lib=/opt/pgbin-build/pgbin/shared/linux_64/lib/
mkdir -p $shared_lib

cp /usr/lib64/libreadline.so.6      $shared_lib/.
cp /usr/lib64/libtermcap.so         $shared_lib/libtermcap.so.2
cp /usr/lib64/libz.so.1             $shared_lib/.
cp /usr/lib64/libssl.so.1.0.2k      $shared_lib/libssl.so.1.0.0
cp /usr/lib64/libcrypto.so.1.0.2k   $shared_lib/libcrypto.so.1.0.0
cp /usr/lib64/libk5crypto.so.3.1    $shared_lib/libk5crypto.so.3
cp /usr/lib64/libkrb5support.so.0.1 $shared_lib/libkrb5support.so.0
cp /usr/lib64/libkrb5.so.3          $shared_lib/.
cp /usr/lib64/libcom_err.so.2.1     $shared_lib/libcom_err.so.3
cp /usr/lib64/libgssapi_krb5.so.2.2 $shared_lib/libgssapi_krb5.so.2
cp /usr/lib64/libxslt.so.1          $shared_lib/.
cp /usr/lib64/libldap-2.4.so.2      $shared_lib/.
cp /usr/lib64/libldap_r-2.4.so.2    $shared_lib/.
cp /usr/lib64/liblber-2.4.so.2      $shared_lib/.
cp /usr/lib64/libsasl2.so.3         $shared_lib/.
cp /usr/lib64/libuuid.so.1.3.0      $shared_lib/libuuid.so.16
cp /usr/lib64/libxml2.so.2.9.1      $shared_lib/libxml2.so
cp /usr/lib64/libevent-2.0.so.5.1.9 $shared_lib/libevent-2.0.so.5
cp /usr/local/lib/libgss.so.3       $shared_lib/.

if [ "$majorV" == "all" ]; then
  runPgBin "$binBld" "$pgSrc-$pg11V.tar.gz" "$pg11BuildV"
  runPgBin "$binBld" "$pgSrc-$pg12V.tar.gz" "$pg12BuildV"
else
  runPgBin "$binBld" "$pgSrc-$pgV.tar.gz" "$pgBuildV"
fi

exit 0
