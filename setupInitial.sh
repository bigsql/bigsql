# PGSQL-IO

EMAIL="denis@lussier.io"
NAME="denis lussier"
git config --global user.email "$EMAIL"
git config --global user.name "$NAME"
git config --global push.default simple
git config --global credential.helper store

yum --version
rc=$?
if [ "$rc" == "0" ]; then
  YUM="y"
else
  YUM="n"
fi

if [ `uname` == 'Darwin' ]; then
  owner_group="$USER:wheel"
  brew install sqlite3 python3 curl wget \
   gcc flex bison zlib readline libxml2 libxslt \
   llvm libuv libevent pkg-config unixodbc
else
  owner_group="$USER:$USER"
  if [ "$YUM" == "y" ]; then
    ## CentOS 7 for AMD builds
    sudo yum -y install -y epel-release python-pip
    sudo yum -y groupinstall 'development tools'
    sudo yum -y install bison-devel libedit-devel zlib-devel \
      openssl-devel libmxl2-devel libxslt-devel libevent-devel \
      perl-ExtUtils-Embed sqlite-devel wget tcl-devel java-1.8.0-openjdk \
      java-1.8.0-openjdk-devel openjade pam-devel openldap-devel \
      uuid-devel curl-devel protobuf-c-devel chrpath docbook-dtds \
      docbook-style-dsssl docbook-style-xsl mkdocs highlight
  else
    ## Ubuntu 16 for ARM builds
    sudo add-apt-repository universe
    sudo apt install sqlite3 python3 curl wget \
      openjdk-11-jdk build-essential flex bison zlib1g-dev \
      libxml2-dev libxslt1-dev libedit-dev libssl-dev chrpath \
      libperl-dev libpython3-dev libtcl-dev pkg-config libevent-dev cmake \
      libcurl4-openssl-dev unixodbc-dev unixodbc-bin \
      odbc-postgresql llvm-6.0-dev
  fi
fi


sudo mkdir /opt/pgbin-build
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
sudo python get-pip.py
rm get-pip.py
sudo pip install awscli
mkdir -p ~/.aws
cd ~/.aws
touch config
# vi config
chmod 600 config

sudo yum -y install python3 python3-devel

## ENV for ~/.bashrc or ~/.bash_profile 
alias git-push="cd ~/dev/pgsql-io; git status; git add .; git commit -m wip; git push"
alias bp="cd ~/dev/pgsql-io; . ./bp.sh"
alias http="cd ~/dev/pgsql-io; ./startHTTP.sh"

export REGION=us-west-2
export BUCKET=s3://pgsql-io-download

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
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
export PATH=$PATH:$JAVA_HOME/bin
export PATH=/opt/rh/devtoolset-7/root/usr/bin/:/opt/rh/llvm-toolset-7/root/usr/bin/:$PATH
export PATH=/usr/local/bin:$PATH

echo ""
echo "Goodbye!"

