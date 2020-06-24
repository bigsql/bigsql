 
####################################################################
######          Copyright (c)  2015-2020 BigSQL           ##########
####################################################################

import util, os

cmd='pip install elasticsearch'
print('   ' + cmd)
os.system(cmd)

cmd='pip install pg_es_fdw'
print('   ' + cmd)
os.system(cmd)

