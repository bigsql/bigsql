
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
tar -xvf cmake-3.15.5.tar.gz
cd cmake-3.15.5
./bootstrap
make -j4
sudo make install
