
sudo yum -y update

sudo yum -y groupinstall 'Development Tools'

YUM="sudo yum -y install"

$YUM bison-devel readline-devel zlib-devel openssl-devel
$YUM libxml2-devel libxslt-devel sqlite-devel wget openjade 
$YUM pam-devel openldap-devel uuid-devel python-devel libuv-devel

$YUM unixODBC-devel llvm-devel clang-devel protobuf-c-devel chrpath

$YUM docbook-dtds docbook-style-dsssl docbook-style-xsl mkdocs highlight
$YUM perl-ExtUtils-Embed libevent-devel curl-devel postgresql-devel

## skip the below for EL8 & Amazon Linux2 #####

$YUM python36 python36-devel
$YUM centos-release-scl
$YUM llvm-toolset-7 llvm-toolset-7-llvm-devel.x86_64

export PATH=/opt/rh/devtoolset-7/root/usr/bin/:/opt/rh/llvm-toolset-7/root/usr/bin/:$PATH
