 
####################################################################
######          Copyright (c)  2015-2020 BigSQL           ##########
####################################################################

import util

ver = "pgXX"
ext = "postgis-2.5"
if ver == "pg12":
  ext = "postgis-3"

util.remove_pgconf_keyval(ver, "shared_preload_libraries", ext)

