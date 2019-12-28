cd ..

date=$1
time=$2

bak=backups/bigsql-backup-$date-$time.tar.gz

if [ -f $bak ]; then
  echo "# restoring backup '$bak'"
else
  echo "ERROR: backup file does not exist"
  echo "       $bak"
  echo ""
  exit 1
fi

echo ""
echo "## removing old directories"
for dir in `ls -d */` ; do
  if [ "$dir" == "backups/" ] || [ "$dir" == "data/" ]; then
    echo "Skipping $dir"
  else
    cmd="rm -rf $dir"
    echo $cmd
    $cmd
  fi
done

echo ""
echo "## restoring backup '$bak'"
cmd="tar xf $bak ."
$cmd
rc=$?

echo ""
echo "exit ($rc)"
exit $rc
