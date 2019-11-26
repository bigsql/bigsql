
cmd="aws s3 sync . s3://dockpg-download/IN"

$cmd $1
rc=$?

exit $rc

