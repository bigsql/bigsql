copyToS3 () {
  region="$1"
  bucket="$2"
  exclude="$3"

  flags="--acl public-read --storage-class STANDARD --recursive"

  cmd="aws --region $region s3 cp . s3://$bucket $flags"

  if [ "$exclude" == "" ]; then
    $cmd
  else
    $cmd --exclude "$exclude/*"
  fi
  rc=$?

  echo ""
}


## MAINLINE ##################################################
if [ $# -ne 1 ]; then
  echo "ERROR: missing dir parameter"
  exit
fi

newOutDir=apg_history/$1

if [ ! -d $newOutDir ]; then
  echo "ERROR: bad dir"
  exit
fi

cd $newOutDir

copyToS3 "us-west-2" "bigsql-download/REPO" ""

exit 0

