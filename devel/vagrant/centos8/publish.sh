v=201910.21.1
b=centos8
a=512
checksum=`shasum -a $a $b.box`
c=`echo "$checksum" | cut -d " " -f1`

d="CentOS 8 minimal server with yum updates and python3/pip3 installed"
s="CentOS 8 minimal server"

vagrant cloud publish -d "$d" -s "$s" --release -u luss -C sha$a -c $c luss/centos8 $v virtualbox $b.box
rc=$?

echo "rc=$rc"
exit $rc
