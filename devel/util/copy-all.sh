outD=out-20200301

rm -rf history/$outD
mkdir history/$outD

cp -p $OUT/* history/$outD/.
rm history/$outD/pgsql-9*
rm history/$outD/pgsql-1*

./copy-to-s3.sh $outD
