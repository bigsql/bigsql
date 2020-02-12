outD=out-20200212

rm -rf history/$outD
mkdir history/$outD

cp -p $OUT/* history/$outD/.
rm history/$outD/bigsql-1*

./copy-to-s3.sh $outD
