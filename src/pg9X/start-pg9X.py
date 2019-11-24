from __future__ import print_function, division
 
####################################################################
######          Copyright (c)  2015-2019 BigSQL           ##########
####################################################################

import os, sys, subprocess, json
import util, startup, time

pgver = "pg9X"
dotver = pgver[2] + "." + pgver[3]

APG_HOME = os.getenv('APG_HOME', '')
homedir = os.path.join(APG_HOME, pgver)
logdir = os.path.join(homedir, pgver)
datadir = util.get_column('datadir', pgver)
isJson = os.getenv("isJson", None)

first_time="no"
if not os.path.isdir(datadir):
  rc=os.system(sys.executable + ' -u ' + homedir + os.sep + 'init-' + pgver + '.py')
  if rc == 0:
    rc=os.system(sys.executable + ' -u ' + homedir + os.sep + 'config-' + pgver + '.py')
  else:
    sys.exit(rc)
  datadir = util.get_column('datadir', pgver)
  first_time="yes"

autostart = util.get_column('autostart', pgver)
logfile   = util.get_column('logdir', pgver) + os.sep + "postgres.log"
svcname   = util.get_column('svcname', pgver, 'PostgreSQL ' + dotver + ' Server')
port      = util.get_column('port', pgver)

isJson = os.getenv("isJson", None)
msg = pgver + " starting on port " + str(port)
if isJson:
  jsonMsg = {}
  jsonMsg['status'] = "wip"
  jsonMsg['component'] = pgver
  jsonMsg['msg'] = msg
  print(json.dumps([jsonMsg]))
else:
  print(msg)

cmd = sys.executable + " " + homedir + os.sep  + "run-pgctl.py"

if util.get_platform() == "Linux" and autostart == "on":
  startup.start_linux("postgresql" + pgver[2:4])
else:
  startCmd = cmd + ' &'
  subprocess.Popen(startCmd, preexec_fn=os.setpgrp(), close_fds=True, shell=True)

isYes = os.getenv("isYes", "False")
pgName = os.getenv("pgName", "")
if ((pgName > "") and (isYes == "True")):
   print("\n # waiting for DB to start...")
   time.sleep(4)
   cmd = os.path.join(pgver, 'bin', 'createdb')
   cmd = cmd + " -U postgres -w -e -p " + str(port) + " " + str(pgName)
   print("\n # " + cmd)

   cmd = os.path.join(APG_HOME, cmd)
   os.system(cmd)

