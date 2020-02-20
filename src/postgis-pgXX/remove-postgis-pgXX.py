 
####################################################################
######          Copyright (c)  2015-2020 BigSQL           ##########
####################################################################

import util

util.remove_pgconf_keyval("postgis", "shared_preload_libraries", "postgis")

