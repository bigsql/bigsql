 
####################################################################
######          Copyright (c)  2015-2020 BigSQL           ##########
####################################################################

import util, datetime, os

util.change_pgconf_keyval("pgXX", "wal_level", "logical", True)
util.change_pgconf_keyval("pgXX", "max_worker_processes", "10", True)
util.change_pgconf_keyval("pgXX", "max_replication_slots", "10", True)
util.change_pgconf_keyval("pgXX", "max_wal_senders", "10", True)

util.change_pgconf_keyval("pgXX", "track_commit_timestamp", "on", True)
util.change_pgconf_keyval("pgXX", "spock.conflict_resolution", "last_update_wins", True)
#util.change_pgconf_keyval("pgXX", "log_min_messages", "debug3", True)

util.change_pgconf_keyval("pgXX", "log_destination", "stderr, csvlog")

util.run_sql_cmd("pgXX", "CREATE EXTENSION file_fdw", True)
util.run_sql_cmd("pgXX", "CREATE SERVER pglog FOREIGN DATA WRAPPER file_fdw", True)

util.change_pgconf_keyval("pgXX", "spock.conflict_resolution", "last_update_wins", True)

day = datetime.datetime.now().strftime('%a')
logdir = util.get_column("logdir", "pgXX")
csvlogfile = logdir + os.sep + "postgresql-" + day + ".csv"
sql = \
"CREATE FOREIGN TABLE pglog ( \
  log_time timestamp(3) with time zone, \
  user_name text, \
  database_name text, \
  process_id integer, \
  connection_from text, \
  session_id text, \
  session_line_num bigint, \
  command_tag text, \
  session_start_time timestamp with time zone, \
  virtual_transaction_id text, \
  transaction_id bigint, \
  error_severity text, \
  sql_state_code text, \
  message text, \
  detail text, \
  hint text, \
  internal_query text, \
  internal_query_pos integer, \
  context text, \
  query text, \
  query_pos integer, \
  location text, \
  application_name text \
) SERVER pglog \
OPTIONS ( filename '" + csvlogfile + "', format 'csv' )"
util.run_sql_cmd("pgXX", sql, True)

util.create_extension("pgXX", "spock", True)

