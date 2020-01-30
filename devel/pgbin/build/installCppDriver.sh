uvV=1.34.0
cpdV=2.15.0

rm -rf *.deb*
wget https://downloads.datastax.com/cpp-driver/ubuntu/16.04/dependencies/libuv/v$uvV/libuv1-dev_$uvV-1_amd64.deb
wget https://downloads.datastax.com/cpp-driver/ubuntu/16.04/cassandra/v$cpdV/cassandra-cpp-driver-dev_$cpdV-1_amd64.deb


