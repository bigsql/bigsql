chrpath_deb=chrpath_0.16-2_amd64.deb
wget http://archive.ubuntu.com/ubuntu/pool/universe/c/chrpath/$chrpath_deb
sudo dpkg -i $chrpath_deb
rm $chrpath_deb*
