outD=out-20200124

rm -rf $outD
mkdir $outD

cp -p $OUT/* $outD/.

./copy-to-s3.sh $outD
