rm -f local.db

sqlite3 local.db < $APG/src/conf/versions.sql
sqlite3 local.db < $APG/src/conf/components.sql
