
if [ "$1" == "12" ]; then
  source bp.sh
  ./dpg install pg12; ./dpg start pg12 -y -d demo; ./dpg status
  ./dpg install plprofiler-pg12 -d demo; ./dpg status

elif [ "$1" == "11" ]; then
  source bp.sh
  ./dpg install pg11; ./dpg start pg11 -y -d demo; ./dpg status
  ./dpg install pgtsql-pg11 -d demo; ./dpg status
  ./dpg install anon-pg11 -d demo; ./dpg status
  ./dpg install timescaledb-pg11 -d demo; ./dpg status
  ./dpg install plprofiler-pg11 -d demo; ./dpg status
  ./dpg install hypopg-pg11 -d demo; ./dpg status
  ./dpg install pglogical-pg11 -d demo; ./dpg status

elif [ "$1" == "10" ]; then
  source bp.sh
  ./dpg install pg10; ./dpg start pg10 -y -d demo; ./dpg status

else
  echo "ERROR: '$1' is an invalid postgres version"
  exit 1
fi

echo ""
echo "Goodbye!"
exit 0

