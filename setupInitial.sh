# BIGSQL-APG

EMAIL="denis@lussier.io"
NAME="denis lussier"
git config --global user.email "$EMAIL"
git config --global user.name "$NAME"
git config --global push.default simple
git config --global credential.helper store

if [ `uname` == 'Darwin' ]; then
  owner_group="$USER:wheel"
  brew install sqlite3 python3 curl wget \
   gcc flex bison zlib readline libxml2 libxslt \
   llvm libuv libevent pkg-config unixodbc
  rc=$?
else
  ## tested on Ubuntu 18
  owner_group="$USER:$USER"
  sudo add-apt-repository universe
  sudo apt install sqlite3 python3 curl wget \
    openjdk-11-jdk build-essential flex bison zlib1g-dev \
    libxml2-dev libxslt1-dev libedit-dev libssl-dev chrpath \
    libperl-dev libpython3-dev pkg-config libevent-dev cmake \
    libcurl4-openssl-dev unixodbc-dev unixodbc-bin \
    odbc-postgresql llvm-6.0-dev
  rc=$?
fi

echo "rc=$rc"
if [ ! "$rc" == "0" ]; then
  exit $rc
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
sudo python3 get-pip.py
rm get-pip.py
sudo pip3 install awscli
mkdir -p ~/.aws
cd ~/.aws
touch config
# vi config
chmod 600 config

## ENV for ~/.bashrc or ~/.bash_profile 
alias git-push="cd ~/dev/bigsql-apg; git status; git add .; git commit -m wip; git push"
alias bp="cd ~/dev/bigsql-apg; . ./bp.sh"
alias http="cd ~/dev/bigsql-apg; ./startHTTP.sh"

export REGION=us-west-2
export BUCKET=s3://bigsql-apg-download

export DEV=$HOME/dev
export HIST=$DEV/history
export IN=$DEV/in
export SRC=$IN/sources
export OUT=$DEV/out
export APG=$DEV/bigsql-apg
export VER=$APG/src/conf/versions.sql
export BLD=/opt/pgbin-build/pgbin/bin

export DEVEL=$APG/devel
export PG=$DEVEL/pg
export PGBIN=$DEVEL/pgbin
export UTIL=$DEVEL/util
export CLI=$APG/cli/scripts
export PSX=$APG/out/posix
export REPO=http://localhost:8000

export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/bin
export PATH=$PATH:$JAVA_HOME/bin

echo ""
echo "Goodbye!"

