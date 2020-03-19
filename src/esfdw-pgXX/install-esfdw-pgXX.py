 
####################################################################
######          Copyright (c)  2015-2020 BigSQL           ##########
####################################################################

import util, os

cmd='sudo pip3 install "elasticsearch>=7,<8"'
print('   ' + cmd)
os.system(cmd)

cmd='sudo pip3 install pg_es_fdw'
print('   ' + cmd)
os.system(cmd)

