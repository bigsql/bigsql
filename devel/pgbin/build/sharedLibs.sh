
apt --version 1> /dev/null 2> /dev/null
rc=$?

if [ `uname` == "Linux" ]; then
  if [ "$rc" == "0" ]; then
    lib64=/usr/lib/`arch`-linux-gnu
  else
    lib64=/usr/lib64/
  fi
elif [ `uname` == "Darwin" ]; then
  lib64=/usr/local/lib
else
  echo "ERROR: Invalid Operating System."
  exit 1
fi 

echo "lib64=$lib64"
shared_lib=/opt/pgbin-build/pgbin/shared/lib/
mkdir -p $shared_lib
rm -f $shared_lib/*

cp -v /lib/aarch64-linux-gnu/liblzma.so.5        $shared_lib/.
cp -v /lib/aarch64-linux-gnu/libz.so.1           $shared_lib/.
cp -v /lib/aarch64-linux-gnu/libssl.so.1.0.0     $shared_lib/.
cp -v /lib/aarch64-linux-gnu/libcrypto.so.1.0.0  $shared_lib/.
#cp -v $lib64/libkrb5*        $shared_lib/.
#cp -v $lib64/libcom_err*     $shared_lib/.
#cp -v $lib64/libgssapi*      $shared_lib/.
#cp -v $lib64/libldap*        $shared_lib/.
cp -v $lib64/libedit.so.2        $shared_lib/.
cp -v $lib64/*termcap*           $shared_lib/.
cp -v $lib64/libxslt*        $shared_lib/.
cp -v $lib64/liblber*        $shared_lib/.
cp -v $lib64/libsasl2*       $shared_lib/.
#cp -v $lib64/libuuid*        $shared_lib/.
cp -v $lib64/libxml2*        $shared_lib/.
cp -v $lib64/libevent*       $shared_lib/.
cp -v $lib64/libicuuc.so.55  $shared_lib/.
cp -v $lib64/libicudata.so.55 $shared_lib/.
#cp -v $lib64/libuv*          $shared_lib/.
#cp -v $lib64/libpython3.?m.so.1.0   $shared_lib/.
#cp -v $lib64/libcassandra.so.2   $shared_lib/.

rm -f $shared_lib/*.a

