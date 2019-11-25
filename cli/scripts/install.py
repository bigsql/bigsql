import sys, os
DPG_VER="1.0"
DPG_REPO=os.getenv("DPG_REPO", "https://dockpg-download.s3.amazonaws.com/REPO")
  
if sys.version_info < (2, 7):
  print("ERROR: DockPG requires Python 2.7 or greater")
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
  print("ERROR: This is a 32bit machine and DockPG packages are 64bit.")
  sys.exit(1)

if os.path.exists("dockpg"):
  print("ERROR: Cannot install over an existing 'dockpg' directory.")
  sys.exit(1)

dpg_file="dockpg-dpg-" + DPG_VER + ".tar.bz2"
f = DPG_REPO + "/" + dpg_file

if not os.path.exists(dpg_file):
  print("\nDownloading DockPG DPG " + DPG_VER + " ...")
  try:
    fu = urllib2.urlopen(f)
    local_file = open(dpg_file, "wb")
    local_file.write(fu.read())
    local_file.close()
  except Exception as e:
    print("ERROR: Unable to download " + f + "\n" + str(e))
    sys.exit(1)

print("\nUnpacking ...")
try:
  tar = tarfile.open(dpg_file)
  tar.extractall(path=".")
  print("\nCleaning up")
  tar.close()
  os.remove(dpg_file)
except Exception as e:
  print("ERROR: Unable to unpack \n" + str(e))
  sys.exit(1)

print("\nSetting REPO to " + DPG_REPO)
dpg_cmd = "dockpg" + os.sep + "dpg"
os.system(dpg_cmd + " set GLOBAL REPO " + DPG_REPO)

print("\nDockPG installed.  Try '" + dpg_cmd + " help' to get started.\n")

sys.exit(0)

