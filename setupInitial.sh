# PGSQL-IO

EMAIL="denis@lussier.io"
NAME="denis lussier"
git config --global user.email "$EMAIL"
git config --global user.name "$NAME"
git config --global push.default simple
git config --global credential.helper store


if [ `uname` == 'Darwin' ]; then
  owner_group="$USER:wheel"
  brew install python3
  brew postinstall python3
  brew install sqlite3 curl wget \
   gcc flex bison zlib readline libxslt \
   libuv libevent pkg-config unixodbc \
   boost geos gdal protobuf-c sfcgal
fi

if [ `uname` == 'Linux' ]; then
  owner_group="$USER:$USER"
  yum --version
  rc=$?
  if [ "$rc" == "0" ]; then
    YUM="y"
  else
    YUM="n"
  fi
  if [ "$YUM" == "y" ]; then
    ## tested on CentOS 7
    sudo yum -y install -y epel-release python-pip
    sudo yum -y groupinstall 'development tools'
    sudo yum -y install bison-devel libedit-devel zlib-devel \
      openssl-devel libmxl2-devel libxslt-devel libevent-devel \
      perl-ExtUtils-Embed sqlite-devel wget tcl-devel java-11-openjdk-devel \
      openjade pam-devel openldap-devel boost-devel \
      gdal-devel geos-devel json-c-devel proj-devel mysql-devel freetds-devel \
      libuv-devel uuid-devel curl-devel protobuf-c-devel chrpath docbook-dtds \
      docbook-style-dsssl docbook-style-xsl mkdocs highlight
    sudo yum -y install clang llvm5.0 centos-release-scl-rh
    sudo yum -y install llvm-toolset-7-llvm devtoolset-7 llvm-toolset-7-clang
    sudo yum -y install python3 python3-devel
  else
    ## tested on Ubuntu 16
    sudo add-apt-repository universe
    sudo apt install sqlite3 python3 curl wget \
      openjdk-8-jdk build-essential flex bison zlib1g-dev libldap-dev \
      libxml2-dev libxslt1-dev libedit-dev libssl-dev chrpath \
      libperl-dev libpython3-dev pkg-config libevent-dev cmake \
      libpam-dev libcurl4-openssl-dev unixodbc-dev unixodbc-bin \
      libossp-uuid-dev odbc-postgresql llvm-8-dev \
      libkrb5-dev tcl-dev 
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

if [ ! -d ~/.aws ]; then
  aws --version
  rc = $?
  if [ ! "$rc" == "0" ]; then
    pip install awscli
  fi
  mkdir -p ~/.aws
  cd ~/.aws
  touch config
  # vi config
  chmod 600 config
fi

export WORKON_HOME=~/Envs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
mkdir -p $WORKON_HOME
pip install virtualenvwrapper


## ENV for ~/.bashrc or ~/.bash_profile ##############################################
alias git-push="cd ~/dev/pgsql-io; git status; git add .; git commit -m wip; git push"
alias bp="cd ~/dev/pgsql-io; . ./bp.sh"
alias ver="vi ~/dev/pgsql-io/src/conf/versions.sql"
alias chalice="workon chalice; cd ~/dev/pgsql-io/www/chalice"

export REGION=us-west-2
export BUCKET=s3://pgsql-io-download

#export WORKON_HOME=$HOME/Envs
#export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
#export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
#source /usr/local/bin/virtualenvwrapper.sh


export DEV=$HOME/dev
export HIST=$DEV/history
export IN=$DEV/in
export SRC=$IN/sources
export OUT=$DEV/out
export IO=$DEV/pgsql-io
export VER=$IO/src/conf/versions.sql
export BLD=/opt/pgbin-build/pgbin/bin

export DEVEL=$IO/devel
export PG=$DEVEL/pg
export PGBIN=$DEVEL/pgbin
export UTIL=$DEVEL/util
export CLI=$IO/cli/scripts
export PSX=$IO/out/posix
export REPO=http://localhost:8000

## for Ubuntu
##export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/bin
##export PATH=$PATH:$JAVA_HOME/bin

## for Centos 7
export PATH=/opt/rh/devtoolset-7/root/usr/bin/:/opt/rh/llvm-toolset-7/root/usr/bin/:$PATH
export PATH=/usr/local/bin:$PATH

## for Java Components like PL/Java, HiveFDW, & BenchmarkSQL
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
export PATH=$JAVA_HOME/bin:$HOME/apache-ant-1.10.7/bin:$HOME/apache-maven-3.6.3/bin:$PATH

echo ""
echo "Goodbye!"

