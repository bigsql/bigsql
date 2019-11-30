import sys, os
MY_VER="19.12-1"
MY_REPO=os.getenv("MY_REPO", "https://pglts-download.s3.amazonaws.com/REPO")
  
if sys.version_info < (2, 7):
  print("ERROR: LTS requires Python 2.7 or greater")
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
  print("ERROR: This is a 32-bit machine and LTS packages are 64-bit.")
  sys.exit(1)

if os.path.exists("pglts"):
  print("ERROR: Cannot install over an existing 'pglts' directory.")
  sys.exit(1)

my_file="pglts-cli-" + MY_VER + ".tar.bz2"
f = MY_REPO + "/" + my_file

if not os.path.exists(my_file):
  print("\nDownloading LTS " + MY_VER + " ...")
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

print("\nSetting REPO to " + MY_REPO)
cmd = "postgres" + os.sep + "lts"
os.system(cmd + " set GLOBAL REPO " + MY_REPO)

print("\nLTS installed.  Try '" + cmd + " help' to get started.\n")

sys.exit(0)

