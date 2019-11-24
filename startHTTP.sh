
pyver=`python3 --version  > /dev/null 2>&1`
rc=$?
if [ "$rc" == "0" ];then
  cmd="python3 -m http.server"
else
  cmd="python -m SimpleHTTPServer"
fi

echo $cmd
cd $OUT
$cmd &

