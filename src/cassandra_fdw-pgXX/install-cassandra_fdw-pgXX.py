 
####################################################################
######          Copyright (c)  2015-2019 BigSQL           ##########
####################################################################

import util, os

ext_nm = "cassandra_fdw"

print("\n install-" + ext_nm + "-pgXX...")

util.change_pgconf_keyval("pgXX", "shared_preload_libraries", ext_nm)

isYes = os.getenv("isYes", "False")
if isYes == "True":
  util.create_extension("pgXX", ext_nm, True)

