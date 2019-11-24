
cmd="aws s3 sync . s3://bigsql-download/IN"

$cmd $1
rc=$?

exit $rc

