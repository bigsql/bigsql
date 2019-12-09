#!/usr/bin/env python
import sys
import logging
logging.basicConfig(stream=sys.stderr)
sys.path.insert(0,"/var/www/bigsql-www-py/")
from run import app as application
