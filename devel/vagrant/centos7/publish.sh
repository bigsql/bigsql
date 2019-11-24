v=201910.21.1
b=centos7
a=512
checksum=`shasum -a $a $b.box`
c=`echo "$checksum" | cut -d " " -f1`

d="CentOS 7 minimal server with yum updates and python-pip from epel-release"
s="CentOS 7 minimal server"

vagrant cloud publish -d "$d" -s "$s" --release -u luss -C sha$a -c $c luss/centos7 $v virtualbox $b.box
rc=$?

echo "rc=$rc"
exit $rc
