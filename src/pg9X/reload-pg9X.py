from __future__ import print_function, division
 
####################################################################
######          Copyright (c)  2015-2019 BigSQL           ##########
####################################################################

import os, sys
import util, startup

pgver = "pg9X"

print(pgver + " reloading")

autostart = util.get_column('autostart', pgver)
if autostart == "on" and util.get_platform() == "Linux":
  rc = startup.reload_linux("postgresql" + pgver[2:4])
  sys.exit(rc)

APG_HOME = os.getenv('APG_HOME', '')
homedir = os.path.join(APG_HOME, pgver)
datadir = util.get_column('datadir', pgver)

pg_ctl = os.path.join(homedir, "bin", "pg_ctl")
parms = ' reload -D "' + datadir + '"'
rc = util.system(pg_ctl + parms)

sys.exit(rc)
