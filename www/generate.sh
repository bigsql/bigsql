COMP=comp

sqlite3 local.db < $APG/src/conf/components.sql
sqlite3 local.db < $APG/src/conf/versions.sql

python3 $COMP.py > $COMP.html

