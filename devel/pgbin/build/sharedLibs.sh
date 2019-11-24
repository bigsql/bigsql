shared_lib=/opt/pgbin-build/pgbin/shared/linux_64/lib/
mkdir -p $shared_lib

cp -v /usr/lib64/libreadline* $shared_lib/.
cp -v /usr/lib64/libtermcap*  $shared_lib/.
cp -v /usr/lib64/libz*        $shared_lib/.
cp -v /usr/lib64/libssl*      $shared_lib/.
cp -v /usr/lib64/lib*crypto*  $shared_lib/.
cp -v /usr/lib64/libkrb5*     $shared_lib/.
cp -v /usr/lib64/libcom_err*  $shared_lib/.
cp -v /usr/lib64/libgssapi*   $shared_lib/.
cp -v /usr/lib64/libxslt*     $shared_lib/.
cp -v /usr/lib64/libldap*     $shared_lib/.
cp -v /usr/lib64/liblber*     $shared_lib/.
cp -v /usr/lib64/libsasl2*    $shared_lib/.
cp -v /usr/lib64/libuuid*     $shared_lib/.
cp -v /usr/lib64/libxml2*     $shared_lib/.
cp -v /usr/lib64/libevent*    $shared_lib/.

rm -f $shared_lib/*.a
