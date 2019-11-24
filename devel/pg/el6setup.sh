
sudo yum -y update

sudo yum install clang
sudo yum -y groupinstall 'Development Tools'

YUM="sudo yum -y install"

$YUM bison-devel readline-devel zlib-devel openssl-devel
$YUM libxml2-devel libxslt-devel sqlite-devel wget openjade 
$YUM pam-devel openldap-devel uuid-devel python-devel chrpath
$YUM docbook-dtds docbook-style-dsssl docbook-style-xsl highlight
$YUM perl-ExtUtils-Embed libevent-devel tcl-devel 

