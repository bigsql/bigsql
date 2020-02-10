# BIGSQL

## UBUNTU 16.04 LTS
```
EMAIL="denis@lussier.io"
NAME="denis lussier"
git config --global user.email "$EMAIL"
git config --global user.name "$NAME"
git config --global push.default simple
git config --global credential.helper store
mkdir -p ~/dev/
cd ~/dev
git clone https://github.com/bigsql/bigsql-apg.git

if [ `uname` == 'DARWIN' ]; then
  brew install sqlite3 python3 curl wget
  brew install gcc flex bison zlib readline libxml2 libxslt
  brew install clang llvm libuv libevent pkg-config unixodbc
else
  APT="sudo apt -y"
  $APT install sqlite3 python3 curl wget
  $APT install openjdk-8-jdk build-essential flex bison zlib1g-dev \
    libxml2-dev libxslt-dev libreadline-dev libssl-dev chrpath \
    libperl-dev libpython3-dev pkg-config libevent-dev cmake \
    libcurl4-openssl-dev *unixodbc* clang lxc lxcfs
fi

sudo mkdir /opt/pgbin-build
sudo chown $USER:$USER /opt/pgbin-build
mkdir -p /opt/pgbin-build/pgbin/bin
sudo mkdir /opt/pgcomponent
sudo chown $USER:$USER /opt/pgcomponent
mkdir -p ~/dev
cd ~/dev
mkdir in
mkdir out
mkdir history

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
```

## ENV for ~/.bashrc or ~/.bash_profile 
```
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
