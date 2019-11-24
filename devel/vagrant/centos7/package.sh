rm -f centos7.box

vagrant package --base centos7 --output centos7.box
rc=$?

echo "rc=$rc"
exit $rc

