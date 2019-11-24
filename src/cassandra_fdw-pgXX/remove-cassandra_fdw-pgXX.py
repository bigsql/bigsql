 
####################################################################
######          Copyright (c)  2015-2019 BigSQL           ##########
####################################################################

import util

print("\n remove-cassandra_fdw-pgXX...")

util.remove_pgconf_keyval("pgXX", "shared_preload_libraries", "cassandra_fdw")

