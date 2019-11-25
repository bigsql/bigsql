# README for DockPG ( http://dockpg.io ) #

# EL7 setup

```
YUM="sudo yum -y"

$YUM update
$YUM groupinstall 'Development Tools'
$YUM install bison-devel readline-devel zlib-devel openssl-devel \
 libxml2-devel libxslt-devel sqlite-devel wget openjade \
 pam-devel openldap-devel uuid-devel python-devel \
 unixODBC-devel llvm-devel clang-devel protobuf-c-devel chrpath \
 docbook-dtds docbook-style-dsssl docbook-style-xsl mkdocs highlight \
 perl-ExtUtils-Embed libevent-devel postgresql-devel \
 git net-tools zip unix2dos wget bzip2 python-pip \
 epel-release java-1.8.0-openjdk java-1.8.0-openjdk-devel \
 centos-release-scl llvm-toolset-7 llvm-toolset-7-llvm-devel

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
mkdir dpg_history

git clone https://github.com/dockpg/dpg

# edit your ~/.bashrc to set env variables
export DEV=$HOME/dev
export HIST=$DEV/dpg_history
export IN=$DEV/in
export OUT=$DEV/out

export DPG=$DEV/dpg
export DEVEL=$DPG/devel
export PG=$DEVEL/pg
export PGBIN=$DEVEL/pgbin

export SRC=$IN/sources
export BLD=/opt/pgbin-build/pgbin/bin

export CLI=$DPG/cli/scripts
export PSX=$DPG/out/posix
export REPO=http://localhost:8000

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
export PATH=$PATH:$JAVA_HOME/bin

export PATH=/opt/rh/devtoolset-7/root/usr/bin/:/opt/rh/llvm-toolset-7/root/usr/bin/:$PATH

```

