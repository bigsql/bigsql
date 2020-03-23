 
####################################################################
######          Copyright (c)  2015-2020 BigSQL           ##########
####################################################################

import util, os

cmd='pip3 install --user "elasticsearch>=7,<8"'
print('   ' + cmd)
os.system(cmd)

cmd='pip3 install --user pg_es_fdw'
print('   ' + cmd)
os.system(cmd)

