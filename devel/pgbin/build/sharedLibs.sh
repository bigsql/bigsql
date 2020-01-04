shared_lib=/opt/pgbin-build/pgbin/shared/linux_64/lib/
mkdir -p $shared_lib

if [ `uname` == "Darwin" ]; then
  lib64=/usr/local/lib
else
  lib64=/usr/lib64
fi

rm -f $shared_lib/*

cp -v $lib64/libreadline*    $shared_lib/.
cp -v $lib64/libtermcap*     $shared_lib/.
cp -v $lib64/libz*           $shared_lib/.
cp -v $lib64/libssl*         $shared_lib/.
cp -v $lib64/libcrypto*      $shared_lib/.
cp -v $lib64/libkrb5*        $shared_lib/.
cp -v $lib64/libcom_err*     $shared_lib/.
cp -v $lib64/libgssapi*      $shared_lib/.
cp -v $lib64/libxslt*        $shared_lib/.
cp -v $lib64/libldap*        $shared_lib/.
cp -v $lib64/liblber*        $shared_lib/.
cp -v $lib64/libsasl2*       $shared_lib/.
cp -v $lib64/libuuid*        $shared_lib/.
cp -v $lib64/libxml2.so.2    $shared_lib/.
cp -v $lib64/libevent*       $shared_lib/.
cp -v $lib64/libpython3.?m.so.1.0   $shared_lib/.
#cp -v $lib64/libcassandra.so.2   $shared_lib/.
cp -v $lib64/libuv.so.1      $shared_lib/.

rm -f $shared_lib/*.a
