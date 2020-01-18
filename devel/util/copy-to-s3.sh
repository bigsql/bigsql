# copy-to-s3

if [ $# -ne 1 ]; then
  echo "ERROR: missing pOutDir parm"
  exit 1
fi

outDir=$HIST/$1
echo $outDir
sleep 3

if [ ! -d $outDir ]; then
  echo "ERROR: missing $outDir"
  exit 1
fi
cd $outDir
ls
sleep 3

exclude="--exclude xyz/*"
flags="--acl public-read --storage-class STANDARD --recursive"
cmd="aws --region $REGION s3 cp . $BUCKET/REPO $flags $exclude"
echo $cmd
sleep 3

$cmd
rc=$?
echo "rc=($rc)"
exit $rc

