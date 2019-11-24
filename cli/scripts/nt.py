from __future__ import print_function, division

import sys, os
if sys.version_info <= (2, 5):
  print("Currently we run best on Python 2.7")
  sys.exit(1)

IS_64BITS = sys.maxsize > 2**32
if not IS_64BITS:
  print("This is a 32bit machine and BigSQL packages are 64bit.\n"
        "Cannot continue")
  sys.exit(1)

import socket, subprocess, time, datetime, hashlib, platform, tarfile
import sqlite3, time, json, glob, re, io, errno, traceback
from shutil import copy2, copytree

try:
  import click
except Exception as e:
  print("CLICK not available")
  sys.exit(1)

import logging, logging.handlers, errno
try:
    ## Globals and other Initializations ##############################
    LOG_FILENAME = os.getenv('APG_LOGS', 
      '..' + os.sep + '..' + os.sep + 'logs' + os.sep + 'apg_log.out')
    LOG_DIRECTORY = os.path.split(LOG_FILENAME)[0]

    if not os.path.isdir(LOG_DIRECTORY):
      os.mkdir(LOG_DIRECTORY)

    # Set up a specific logger with our desired output level
    my_logger = logging.getLogger('apg_logger')
    COMMAND = 9
    logging.addLevelName(COMMAND, "COMMAND")
    my_logger.setLevel(logging.DEBUG)


    # Add the log message handler to the logger
    handler = logging.handlers.RotatingFileHandler(
                  LOG_FILENAME, maxBytes=10*1024*1024, backupCount=5)

    formatter = logging.Formatter('%(asctime)s [%(levelname)s] : %(message)s',
                                  datefmt='%Y-%m-%d %H:%M:%S')

    handler.setFormatter(formatter)
    my_logger.addHandler(handler)
except (IOError, OSError) as err:
    print(str(err))
    if err.errno in (errno.EACCES, errno.EPERM):
      print("You must run as administrator/root.")
    exit()

