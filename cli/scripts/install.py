import sys, os

VER="6.22"
REPO=os.getenv("REPO", "https://pgsql-io-download.s3.amazonaws.com/REPO")
  
if sys.version_info < (2, 7):
  print("ERROR: Requires Python 2.7 or greater")
  sys.exit(1)

try:
  # For Python 3.0 and later
  from urllib import request as urllib2
except ImportError:
  # Fall back to Python 2's urllib2
  import urllib2

import tarfile

IS_64BITS = sys.maxsize > 2**32
if not IS_64BITS:
  print("ERROR: This is a 32-bit machine and our packages are 64-bit.")
  sys.exit(1)

if os.path.exists("pgsql"):
  print("ERROR: Cannot install over an existing 'pgsql' directory.")
  sys.exit(1)

my_file="pgsql-io-" + VER + ".tar.bz2"
f = REPO + "/" + my_file

if not os.path.exists(my_file):
  print("\nDownloading CLI " + VER + " ...")
  try:
    fu = urllib2.urlopen(f)
    local_file = open(my_file, "wb")
    local_file.write(fu.read())
    local_file.close()
  except Exception as e:
    print("ERROR: Unable to download " + f + "\n" + str(e))
    sys.exit(1)

print("\nUnpacking ...")
try:
  tar = tarfile.open(my_file)
  tar.extractall(path=".")
  print("\nCleaning up")
  tar.close()
  os.remove(my_file)
except Exception as e:
  print("ERROR: Unable to unpack \n" + str(e))
  sys.exit(1)

print("\nSetting REPO to " + REPO)
cmd = "pgsql" + os.sep + "io"
os.system(cmd + " set GLOBAL REPO " + REPO)

print("\nPGSQL installed.  Try '" + cmd + " help' to get started.\n")

sys.exit(0)

