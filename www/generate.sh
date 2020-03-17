COMP=components

sqlite3 local.db < $IO/src/conf/components.sql
sqlite3 local.db < $IO/src/conf/versions.sql

python $COMP.py > html/$COMP.html

