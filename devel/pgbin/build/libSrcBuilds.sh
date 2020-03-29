
## pg built using --with-libgss
cd ~
VER=1.0.3
wget ftp://ftp.gnu.org/gnu/gss/gss-$VER.tar.gz
tar -xvf gss-$VER.tar.gz
cd gss-$VER
./configure
make -j4
sudo make install

# recent CMAKE needed for timescaledb
cd ~
wget https://cmake.org/files/v3.15/cmake-3.15.5.tar.gz
tar -xvzf cmake-3.15.5.tar.gz
cd cmake-3.15.5
./bootstrap
make -j4
sudo make install

# recent Maven needed for PL/Java Builds
cd ~
VER=3.6.3
wget https://downloads.apache.org/maven/maven-3/$VER/binaries/apache-maven-$VER-bin.tar.gz
tar -xvzf apache-maven-$VER-bin.tar.gz

# recent ANT for BenchmarkSQL Builds
cd ~
VER=1.9.14
wget http://us.mirrors.quenda.co/apache//ant/binaries/apache-ant-$VER-bin.tar.gz
tar -xvzf apache-ant-$VER-bin.tar.gz

