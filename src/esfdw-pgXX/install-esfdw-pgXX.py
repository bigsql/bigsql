 
####################################################################
######          Copyright (c)  2015-2020 BigSQL           ##########
####################################################################

import util, os

cmd='pip install elasticsearch'
print('   ' + cmd)
os.system(cmd)

cmd="pip install 'pg_es_fdw==0.8.0'"
print('   ' + cmd)
os.system(cmd)

