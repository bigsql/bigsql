outD=out-20200210

rm -rf $outD
mkdir $outD

cp -p $OUT/* $outD/.

./copy-to-s3.sh $outD
