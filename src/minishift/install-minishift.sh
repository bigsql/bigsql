
OS=`uname`

if [ "$OS" == "Darwin" ]; then
  hyperv=docker-machine-driver-xhyve
  curl -L https://github.com/zchee/$hyperv/releases/download/v0.3.3/$hyperv > /usr/local/bin/$hyperv
  sudo chown root:wheel $(brew --prefix)/opt/$hyperv/bin/$hyperv
  sudo chmod u+s $(brew --prefix)/opt/$hyperv/bin/$hyperv
  brew info $hyperv
  brew cask install --force minishift
  rc=$?
  echo "rc=$rc"
  exit $rc
fi
