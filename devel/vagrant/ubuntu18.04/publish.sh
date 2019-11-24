v=201910.28.1
b=ubuntu18.04
a=512
checksum=`shasum -a $a $b.box`
c=`echo "$checksum" | cut -d " " -f1`

d="Ubuntu 18.04 minimal server with apt upgrades & Guest Additions"
s="Ubuntu 18.04 minimal server"

vagrant cloud publish -d "$d" -s "$s" --release -u luss -C sha$a -c $c luss/centos7 $v virtualbox $b.box
rc=$?

echo "rc=$rc"
exit $rc
