
BUILD=/opt/pgbin-build

sudo mkdir $BUILD 2>/dev/null
sudo chown $USER:$USER $BUILD

SRC=$BUILD/sources
mkdir $SRC 2>/dev/null

mkdir $BUILD/pgbin 2>/dev/null
BLD=$BUILD/pgbin/bin
mkdir $BLD 2>/dev/null

cp -v build-*.sh $BLD/.
cp -v versions.sh $BLD/.

PGURL="https://ftp.postgresql.org/pub/source"
rm -f *.tar.gz
source versions.sh

echo " "
wget $PGURL/v$pg11V/postgresql-$pg11V.tar.gz
echo " "
wget $PGURL/v$pg12V/postgresql-$pg12V.tar.gz

echo " "
wget https://github.com/pgbackrest/pgbackrest/archive/release/$backrestV.tar.gz
tar -xf $backrestV.tar.gz
mv pgbackrest-release-$backrestV backrest-$backrestV
tar czf backrest-$backrestV.tar.gz backrest-$backrestV
rm -rf backrest-$backrestV
rm $backrestV.tar.gz


echo ""
wget https://ftp.postgresql.org/pub/odbc/versions/src/psqlodbc-$odbcV.tar.gz

echo ""
wget http://pgbouncer.github.io/downloads/files/$bouncerV/pgbouncer-$bouncerV.tar.gz

mv -v *.gz $SRC/.

