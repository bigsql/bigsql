# PGSQL-IO for ~/.bash... ############################################################
alias git-push="cd ~/dev/pgsql-io; git status; git add .; git commit -m wip; git push"
alias bp="cd ~/dev/pgsql-io; . ./bp.sh"
alias ver="vi ~/dev/pgsql-io/src/conf/versions.sql"
alias chalice="workon chalice; cd ~/dev/pgsql-io/www/chalice"

export REGION=us-west-2
export BUCKET=s3://pgsql-io-download

export DEV=$HOME/dev
export IN=$DEV/in
export OUT=$DEV/out
export IO=$DEV/pgsql-io
export SRC=$IN/sources
export BLD=/opt/pgbin-build/pgbin/bin
export VER=$APG/src/conf/versions.sql

export DEVEL=$IO/devel
export PG=$DEVEL/pg
export PGB=$DEVEL/pgbin
export UTL=$DEVEL/util
export CLI=$IO/cli/scripts
export REPO=http://localhost:8000

export WORKON_HOME=$HOME/Envs
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'

# OSX specific for ~/.bash_profile #############################
opt=/usr/local/opt
export LDFLAGS="-L$opt/llvm/lib -L$opt/openssl/lib"
export CPPFLAGS="-I$opt/llvm/include -I$opt/openssl/include"
export PKG_CONFIG_PATH="$opt/openssl/lib/pkgconfig"
export PATH="$opt/llvm/bin:$opt/python/libexec/bin:$PATH"

# Bottom of ~/.bash... ########################################
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
source /usr/local/bin/virtualenvwrapper.sh
