
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

shared_lib=/opt/pgbin-build/pgbin/shared/lib/
mkdir -p $shared_lib
rm -f $shared_lib/*

cp -v $lib64/libz.so.1       $shared_lib/.
cp -v $lib64/libc.so.6       $shared_lib/.
cp -v $lib64/libm.so.6       $shared_lib/.
cp -v $lib64/librt.so.1       $shared_lib/.
cp -v $lib64/libdl.so.2       $shared_lib/.
cp -v $lib64/libssl*         $shared_lib/.
cp -v $lib64/libcrypt.so.1   $shared_lib/.
cp -v $lib64/libkrb5*        $shared_lib/.
cp -v $lib64/libgssapi*      $shared_lib/.
cp -v $lib64/libldap*        $shared_lib/.
cp -v $lib64/libedit*        $shared_lib/.
cp -v $lib64/libxml2.so.2    $shared_lib/.
cp -v $lib64/libxslt.so*     $shared_lib/.
cp -v $lib64/liblber*        $shared_lib/.
cp -v $lib64/libsasl2*       $shared_lib/.
cp -v $lib64/libevent*       $shared_lib/.

cp -v $lib64/libcrypto.so.10      $shared_lib/.
cp -v $lib64/libk5crypto.so.3     $shared_lib/.
cp -v $lib64/libnss3*             $shared_lib/.
cp -v $lib64/libnspr4*            $shared_lib/.
cp -v $lib64/libnssutil3*         $shared_lib/.
cp -v $lib64/libsmime*            $shared_lib/.
cp -v $lib64/libplds4*            $shared_lib/.
cp -v $lib64/libplc4*             $shared_lib/.
cp -v $lib64/libpcre.so.1         $shared_lib/.
cp -v $lib64/libfreebl3.so        $shared_lib/.
cp -v $lib64/libselinux.so.1      $shared_lib/.
cp -v $lib64/libcap-ng.so.0       $shared_lib/.
cp -v $lib64/libaudit.so.1        $shared_lib/.
cp -v $lib64/libresolv.so.2       $shared_lib/.
cp -v $lib64/liblzma.so.5         $shared_lib/.
cp -v $lib64/libcom_err.so.2      $shared_lib/.
cp -v $lib64/libkeyutils.so.1     $shared_lib/.
cp -v $lib64/libpthread.so.0      $shared_lib/.
cp -v $lib64/libpam.so.0          $shared_lib/.
cp -v $lib64/libpython3.6m.so.1.0 $shared_lib/.
#cp -v $lib64/libcassandra.so.2   $shared_lib/.

rm -f $shared_lib/*.a

