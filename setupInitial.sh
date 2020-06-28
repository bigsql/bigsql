# PGSQL-IO

EMAIL="denis@lussier.io"
NAME="denis lussier"
git config --global user.email "$EMAIL"
git config --global user.name "$NAME"
git config --global push.default simple
git config --global credential.helper store


if [ `uname` == 'Linux' ]; then
  owner_group="$USER:$USER"
  yum --version 2>&1
  rc=$?
  if [ "$rc" == "0" ]; then
    YUM="y"
  else
    YUM="n"
  fi
  if [ "$YUM" == "y" ]; then
    ## CentOS 7
    sudo yum -y install -y epel-release python-pip
    sudo yum -y groupinstall 'development tools'
    sudo yum -y install bison-devel libedit-devel zlib-devel bzip2-devel \
      openssl-devel libmxl2-devel libxslt-devel libevent-devel c-ares-devel \
      perl-ExtUtils-Embed sqlite-devel wget tcl-devel java-11-openjdk-devel \
      openjade pam-devel openldap-devel boost-devel unixODBC-devel \
      gdal-devel geos-devel json-c-devel proj-devel mysql-devel freetds-devel \
      libuv-devel uuid-devel curl-devel protobuf-c-devel chrpath docbook-dtds \
      docbook-style-dsssl docbook-style-xsl mkdocs highlight
    sudo yum -y install clang llvm5.0 centos-release-scl-rh
    sudo yum -y install llvm-toolset-7-llvm devtoolset-7 llvm-toolset-7-clang
    sudo yum -y install python3 python3-devel
  else
    ## Debian 10 (buster)
    sudo apt install sqlite3 python3 curl wget \
      openjdk-11-jdk build-essential flex bison zlib1g-dev libldap2-dev \
      libxml2-dev libxslt1-dev libedit-dev libssl-dev chrpath \
      libperl-dev libpython3-dev pkg-config libevent-dev cmake \
      libpam0g-dev libcurl4-openssl-dev unixodbc-dev unixodbc-bin \
      libossp-uuid-dev libkrb5-dev llvm-8 clang-8 python3-distutils
  fi
fi

sudo mkdir -p /opt/pgbin-build
sudo chown $owner_group /opt/pgbin-build
mkdir -p /opt/pgbin-build/pgbin/bin
sudo mkdir -p /opt/pgcomponent
sudo chown $owner_group /opt/pgcomponent
mkdir -p ~/dev
cd ~/dev
mkdir -p in
mkdir -p out
mkdir -p history

cd ~
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
rm get-pip.py

aws --version 2>&1
rc=$?
if [ ! "$rc" == "0" ]; then
  pip install awscli
  mkdir -p ~/.aws
  cd ~/.aws
  touch config
  # vi config
  chmod 600 config
fi

virtualenv --version
rc=$?
if [ ! "$rc" == "0" ]; then
  export WORKON_HOME=~/Envs
  export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
  mkdir -p $WORKON_HOME
  pip install virtualenvwrapper
fi

cd ~/dev/pgsql-io
if [ -f ~/.bashrc ]; then
  bf=~/.bashrc
else
  bf=~/.bash_profile
fi
grep IO $bf
rc=$?
if [ ! "$rc" == "0" ]; then
  cat bash_profile >> $bf
fi

echo ""
echo "Goodbye!"
