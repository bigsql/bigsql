 
####################################################################
######          Copyright (c)  2015-2020 BigSQL           #########
####################################################################

import util

util.pre_install_extension("pgXX", "citus")

util.change_pgconf_keyval("pgXX", "citus.enable_statistics_collection", "off", True)

util.create_extension("pgXX", "citus", True)

