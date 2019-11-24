export base=ubuntu18.04
rm -f $base.box

vagrant package --base $base --output $base.box
rc=$?

echo "rc=$rc"
exit $rc

