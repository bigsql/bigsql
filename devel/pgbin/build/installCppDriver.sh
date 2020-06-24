cpdV=2.15.2

rm -rf *.rpm*
cas=https://downloads.datastax.com/cpp-driver/centos/7/cassandra

rpm=cassandra-cpp-driver-$cpdV-1.el7.x86_64.rpm
wget $cas/v$cpdV/$rpm
sudo yum install -y $rpm


rpm=cassandra-cpp-driver-devel-$cpdV-1.el7.x86_64.rpm
wget $cas/v$cpdV/$rpm
sudo yum install -y $rpm

rm *.rpm



