
if [ "$1" == "12" ]; then
  source bp.sh
  ./apg install pg12; ./apg start pg12 -y -d demo; ./apg status
  ./apg install plprofiler-pg12 -d demo; ./apg status

elif [ "$1" == "11" ]; then
  source bp.sh
  ./apg install pg11; ./apg start pg11 -y -d demo; ./apg status
  ./apg install pgtsql-pg11 -d demo; ./apg status
  ./apg install anon-pg11 -d demo; ./apg status
  ./apg install timescaledb-pg11 -d demo; ./apg status
  ./apg install plprofiler-pg11 -d demo; ./apg status
  ./apg install hypopg-pg11 -d demo; ./apg status
  ./apg install pglogical-pg11 -d demo; ./apg status

elif [ "$1" == "10" ]; then
  source bp.sh
  ./apg install pg10; ./apg start pg10 -y -d demo; ./apg status

else
  echo "ERROR: '$1' is an invalid postgres version"
  exit 1
fi

echo ""
echo "Goodbye!"
exit 0

