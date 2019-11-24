
sudo yum -y update

sudo yum -y groupinstall 'Development Tools'

YUM="sudo yum -y install"

$YUM python3

$YUM readline zlib openssl
$YUM readline-devel zlib-devel openssl-devel python-devel

$YUM libxml2 libxslt sqlite pam openldap
$YUM libxml2-devel libxslt-devel sqlite-devel pam-devel openldap-devel

wget http://rpms.remirepo.net/enterprise/8/remi/x86_64/remi-release-8.0-4.el8.remi.noarch.rpm
sudo rpm -Uvh remi-release*rpm
sudo yum --enablerepo=remi -y install openjade
rm remi-release*rpm

$YUM uuid llvm-toolset chrpath protobuf-c

$YUM docbook-dtds docbook-style-xsl highlight
sudo pip3 install mkdocs

$YUM perl-ExtUtils-Embed libevent-devel tcl-devel postgresql-devel

