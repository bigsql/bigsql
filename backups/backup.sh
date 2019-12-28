
# pass options to tar such as "--exclude=data"
options="$1"

cd ..
./apg stop

now=`date +%Y%m%d-%H%M%S`
file="bigsql-backup-$now.tar.gz"
dir="backups"

cmd="tar czf $dir/$file . --exclude=$dir $options"
echo "# $cmd"
$cmd
rc=$?

echo ""
if [ "$rc" == "0" ]; then
  ls -lh $dir/$file
fi
echo "exit ($rc)"
exit $rc


