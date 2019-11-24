rm -f centos8.box

vagrant package --base centos8 --output centos8.box
rc=$?

echo "rc=$rc"
exit $rc

