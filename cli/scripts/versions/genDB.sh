rm -f local.db

sqlite3 local.db < $DPG/src/conf/versions.sql
sqlite3 local.db < $DPG/src/conf/components.sql
