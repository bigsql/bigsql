# README.md bigsql-apg

## UBUNTU 16.04 LTS (XENIAL) SETUP ####################
```
APT="sudo apt -y"
$APT update
$APT upgrade
$APT install git
EMAIL="denis@lussier.io"
NAME="denis lussier"
git config --global user.email "$EMAIL"
git config --global user.name "$NAME"
git config --global push.default simple
git config --global credential.helper store
mkdir -p ~/dev/
cd ~/dev
git clone https://github.com/bigsql/bigsql-apg.git
$APT install sqlite3 python3 curl wget
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
sudo python3 get-pip.py
sudo pip3 install awscli
$APT install openjdk-8-jdk
$APT install build-essential flex bison
$APT install zlib1g-dev libxml2-dev libxslt-dev libreadline-dev libssl-dev chrpath
$APT install libperl-dev libpython3-dev
$APT install pkg-config libevent-dev cmake libcurl4-openssl-dev *unixodbc*
sudo apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-6.0 main"
$APT install clang-6.0
$APT install lxc lxd lxcfs
sudo mkdir /opt/pgbin-build
sudo chmod 777 /opt/pgbin-build
sudo chown $USER:$USER /opt/pgbin-build
mkdir /opt/pgbin-build/pgbin
mkdir /opt/pgbin-build/pgbin/bin
sudo mkdir /opt/pgcomponent
sudo chmod 777 /opt/pgcomponent
sudo chown $USER:$USER /opt/pgcomponent
mkdir -p ~/dev
cd ~/dev
mkdir in
mkdir out
mkdir apg_history
mkdir -p ~/.aws
cd ~/.aws
```

## ENV setup for .bashrc #########################
```
export REGION=us-west-2
export BUCKET=s3://bigsql-apg-download

export DEV=$HOME/dev
export IN=$DEV/in
export OUT=$DEV/out
export APG=$DEV/bigsql-apg
export SRC=$IN/sources
export BLD=/opt/pgbin-build/pgbin/bin

export DEVEL=$APG/devel
export PG=$DEVEL/pg
export PGBIN=$DEVEL/pgbin
export UTIL=$DEVEL/util
export CLI=$APG/cli/scripts
export PSX=$APG/out/posix
export REPO=http://localhost:8000

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/bin
export PATH=$PATH:$JAVA_HOME/bin
```

## OTHER setup after ~/.bashrc, ~/.aws & /opt/pgbin-build #######
```
cd $IN
cp $APG/devel/util/pull-s3.sh .
./pull-s3.sh
chmod 755 *.sh

cd $BLD
cp -p $APG/devel/pgbin/build/* .
./sharedLibs.sh
./build-all-pgbin.sh 11
```
