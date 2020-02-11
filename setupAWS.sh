
cd $IN
cp $APG/devel/util/pull-s3.sh .
./pull-s3.sh
chmod 755 *.sh

cd $BLD
cp -p $APG/devel/pgbin/build/* .
