pyver=`python3 --version  > /dev/null 2>&1`
rc=$?
if [ "$rc" == "0" ]; then
  pid=`ps aux | grep "[h]ttp.server" | awk '{print $2}'`
  if [ "$pid" > " " ]; then
    echo "killing ($pid)"
    kill -9 $pid
  fi
  rm -f " "
  cmd="python3 -m http.server"
else
  cmd="python -m SimpleHTTPServer"
fi

echo $cmd
cd $OUT
$cmd &

