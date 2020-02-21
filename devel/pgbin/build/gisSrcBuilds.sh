sudo mkdir -p /opt/gis-tools
sudo chown $USER:$USER /opt/gis-tools

function buildGeos {
  cd /opt/gis-tools
  VER=3.7.3
  wget http://download.osgeo.org/geos/geos-$VER.tar.bz2
  tar -xvf geos-$VER.tar.bz2
  cd geos-$VER
  ./configure
  sudo make install
  return
}

############# MAINLINE ###################
buildGeos

