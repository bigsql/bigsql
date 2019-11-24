
import os, sys

pgver="pg9X"

isYes = str(os.getenv("isYes", "False"))

if isYes != "True":
  sys.exit(0)

thisDir = os.path.dirname(os.path.realpath(__file__))
script = thisDir + os.sep + "init-" + pgver + ".py"
cmd = sys.executable + " -u " + script

#print ("Starting " + pgver +":")
#print ("    " + cmd)

rc = os.system(cmd)

# This script runs after the install script succeeds and must
# therefore always return success
sys.exit(0)

