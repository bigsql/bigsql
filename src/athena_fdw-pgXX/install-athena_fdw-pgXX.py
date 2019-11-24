 
####################################################################
######          Copyright (c)  2015-2019 BigSQL           ##########
####################################################################

import util, os

ext_nm = "athena_fdw"

jre_libjvm = "/etc/alternatives/jre_1.8.0/lib/amd64/server/libjvm.so"
pgc_libjvm = os.getenv("PGC_HOME","") + "/pgXX/lib/libjvm.so"
os.system("ln -fs " + jre_libjvm + " " + pgc_libjvm)

util.create_extension("pgXX", ext_nm, True) 

