# README for BigSQL #

# RHEL8 Development Environment setup

```
YUM="sudo yum -y"
$YUM update

$YUM install git

$YUM install python3 python3-pip

sudo pip3 install awscli

$YUM install net-tools zip unix2dos wget bzip2 \
  java-1.8.0-openjdk java-1.8.0-openjdk-devel

$YUM groupinstall 'Development Tools'

$YUM install readline-devel zlib-devel openssl-devel \
  libxml2-devel libxslt-devel sqlite-devel \
  pam-devel openldap-devel python3-devel libcurl-devel \
  unixODBC-devel llvm-devel clang-devel chrpath \
  docbook-dtds docbook-style-xsl cmake \
  perl-ExtUtils-Embed libevent-devel postgresql-devel

$YUM remove docker docker-client docker-client-latest \
  docker-common docker-latest docker-latest-logrotate \
  docker-logrotate docker-engine
$YUM install yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
$YUM install docker-ce containerd.io --nobest
sudo systemctl enable docker
sudo systemctl restart docker

sudo mkdir /opt/pgbin-build
sudo chmod 777 /opt/pgbin-build
sudo chown $USER:$USER /opt/pgbin-build
mkdir /opt/pgbin-build/pgbin
mkdir /opt/pgbin-build/pgbin/bin
sudo mkdir /opt/pgcomponent
sudo chmod 777 /opt/pgcomponent
sudo chown $USER:$USER /opt/pgcomponent

mkdir ~/dev
cd ~/dev
mkdir in
mkdir out
mkdir apg_history

# edit your ~/.bashrc to set env variables
export DEV=$HOME/dev
export HIST=$DEV/apg_history
export IN=$DEV/in
export OUT=$DEV/out

export APG=$DEV/apg
export DEVEL=$APG/devel
export PG=$DEVEL/pg
export PGBIN=$DEVEL/pgbin

export SRC=$IN/sources
export BLD=/opt/pgbin-build/pgbin/bin

export CLI=$APG/cli/scripts
export PSX=$APG/out/posix
export REPO=http://localhost:8000

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
export PATH=$PATH:$JAVA_HOME/bin

####################################
cd $BLD
cp -p $APG/devel/pgbin/build/* .

cd ~
mkdir .aws
cd .aws
vi config
chmod 600 config

cd $IN
cp $APG/devel/util/pull-s3.sh .
./pull-s3.sh
chmod 755 *.sh

```
