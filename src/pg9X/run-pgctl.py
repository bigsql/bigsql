from __future__ import print_function, division
 
####################################################################
######          Copyright (c)  2015-2019 BigSQL           ##########
####################################################################

import subprocess
import os
import sys

APG_HOME = os.getenv("APG_HOME", "")
sys.path.append(os.path.join(APG_HOME, 'hub', 'scripts'))
sys.path.append(os.path.join(APG_HOME, 'hub', 'scripts', 'lib'))

import util

util.set_lang_path()
 
pgver = "pg9X"

dotver = pgver[2] + "." + pgver[3]

datadir = util.get_column('datadir', pgver)

logdir = util.get_column('logdir', pgver)

autostart = util.get_column('autostart', pgver)

pg_ctl = os.path.join(APG_HOME, pgver, "bin", "pg_ctl")
logfile = util.get_column('logdir', pgver) + os.sep + "postgres.log"

util.read_env_file(pgver)

if util.get_platform() == "Windows":
  cmd = pg_ctl + ' start -s -w -D "' + datadir + '" '
  util.system(cmd)
elif util.get_platform() == "Darwin" and autostart == "on":
  postgres = os.path.join(APG_HOME , pgver, "bin", "postgres")
  util.system(postgres +' -D ' + datadir + ' -r ' + logfile)  
else:
  cmd = pg_ctl + ' start -s -w -D "' + datadir + '" ' + '-l "' + logfile + '"'
  util.system(cmd)
