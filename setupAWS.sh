
cd $IN
cp $IO/devel/util/pull-s3.sh .
./pull-s3.sh
chmod 755 *.sh

cd $BLD
cp -p $IO/devel/pgbin/build/* .
