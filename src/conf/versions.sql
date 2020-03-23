DROP VIEW  IF EXISTS v_versions;

DROP TABLE IF EXISTS versions;
DROP TABLE IF EXISTS releases;
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS categories;

CREATE TABLE categories (
  category    INTEGER NOT NULL PRIMARY KEY,
  description TEXT    NOT NULL,
  short_desc  TEXT    NOT NULL
);

CREATE TABLE projects (
  project   	 TEXT     NOT NULL PRIMARY KEY,
  category  	 INTEGER  NOT NULL,
  port      	 INTEGER  NOT NULL,
  depends   	 TEXT     NOT NULL,
  start_order    INTEGER  NOT NULL,
  sources_url    TEXT     NOT NULL,
  short_name     TEXT     NOT NULL,
  is_extension   SMALLINT NOT NULL,
  image_file     TEXT     NOT NULL,
  description    TEXT     NOT NULL,
  project_url    TEXT     NOT NULL,
  FOREIGN KEY (category) REFERENCES categories(category)
);

CREATE TABLE releases (
  component  TEXT     NOT NULL PRIMARY KEY,
  sort_order SMALLINT NOT NULL,
  project    TEXT     NOT NULL,
  disp_name  TEXT     NOT NULL,
  doc_url    TEXT     NOT NULL,
  stage      TEXT     NOT NULL,
  is_open    SMALLINT NOT NULL DEFAULT 1,
  FOREIGN KEY (project) REFERENCES projects(project)
);

CREATE TABLE versions (
  component     TEXT    NOT NULL,
  version       TEXT    NOT NULL,
  platform      TEXT    NOT NULL,
  is_current    INTEGER NOT NULL,
  release_date  DATE    NOT NULL,
  parent        TEXT    NOT NULL,
  PRIMARY KEY (component, version),
  FOREIGN KEY (component) REFERENCES releases(component)
);

CREATE VIEW v_versions AS
  SELECT p.category as cat, r.sort_order, c.description as cat_desc, c.short_desc as cat_short_desc,
         p.image_file, r.component, r.project, r.stage, r.disp_name as release_name,
         v.version, p.sources_url, p.project_url, v.platform, 
         v.is_current, v.release_date, p.description as proj_desc
    FROM categories c, projects p, releases r, versions v
   WHERE c.category = p.category
     AND p.project = r.project
     AND r.component = v.component;

-- ##
INSERT INTO categories VALUES (0, 'Hidden', 'NotShown');
INSERT INTO projects VALUES ('hub',0, 0, 'hub', 0, 'https://github.com/','',0,'','','');
INSERT INTO releases VALUES ('hub', 1, 'hub', '', '', 'hidden', 1);
INSERT INTO versions VALUES ('hub', '6.22', '',  1, '20200323', '');
INSERT INTO versions VALUES ('hub', '6.21', '',  0, '20200315', '');
INSERT INTO versions VALUES ('hub', '6.2',  '',  0, '20200305', '');

-- ##
INSERT INTO categories VALUES (1, 'Rock Solid Postgres', 'Postgres');
INSERT INTO projects VALUES ('pg', 1, 5432, 'hub', 1, 'https://postgresql.org/download',
 'postgres', 0, 'postgresql.png', 'Best RDBMS', 'https://postgresql.org');

INSERT INTO releases VALUES ('pg95', 5, 'pg', 'PostgreSQL', '', 'test', 1);
INSERT INTO versions VALUES ('pg95', '9.5.21-3', 'amd', 1, '20200213','');

INSERT INTO releases VALUES ('pg96', 4, 'pg', 'PostgreSQL', '', 'test', 1);
INSERT INTO versions VALUES ('pg96', '9.6.17-3', 'amd', 1, '20200213','');

INSERT INTO releases VALUES ('pg10', 3, 'pg', 'PostgreSQL', '', 'test', 1);
INSERT INTO versions VALUES ('pg10', '10.12-3', 'amd', 1, '20200213','');

INSERT INTO releases VALUES ('pg11', 2, 'pg', 'PostgreSQL', '', 'prod', 1);
INSERT INTO versions VALUES ('pg11', '11.7-4', 'arm, amd, osx', 1, '20200213','');
INSERT INTO versions VALUES ('pg11', '11.7-3', 'arm, amd, osx', 0, '20200213','');

INSERT INTO releases VALUES ('pg12', 1, 'pg', 'PostgreSQL', '', 'prod', 1);
INSERT INTO versions VALUES ('pg12', '12.2-4', 'amd, arm, osx', 1, '20200213','');
INSERT INTO versions VALUES ('pg12', '12.2-3', 'arm, amd, osx', 0, '20200213','');

-- ##
INSERT INTO categories VALUES (5, 'Foreign Data Wrappers', 'FDWs');
INSERT INTO projects VALUES ('cassandra', 5, 0, 'hub', 0, 'https://cassandra.apache.org', 
  'cassandra', 0, 'cstar.png', 'Multi-Master Big Data', 'https://cassandra.apache.org');
INSERT INTO releases VALUES ('cassandra', 11, 'cassandra','Cassandra', '', 'soon', 1);
INSERT INTO versions VALUES ('cassandra', '3.11.5', '', 0, '20191029', '');

INSERT INTO projects VALUES ('cassandrafdw', 5, 0, 'hub', 0, 'https://github.com/bigsql/cassandra_fdw/releases', 
  'cstarfdw', 1, 'cstar.png', 'Cassandra from PG', 'https://github.com/bigsql/cassandra_fdw#cassandra_fdw');
INSERT INTO releases VALUES ('cassandrafdw-pg11', 12, 'cassandrafdw', 'CassandraFDW','','test', 1);
INSERT INTO releases VALUES ('cassandrafdw-pg12', 12, 'cassandrafdw', 'CassandraFDW','','test', 1);
INSERT INTO versions VALUES ('cassandrafdw-pg11', '3.1.5-1', 'amd', 1, '20191230', 'pg11');
INSERT INTO versions VALUES ('cassandrafdw-pg12', '3.1.5-1', 'amd', 1, '20191230', 'pg12');

INSERT INTO projects VALUES ('hive', 5, 0, 'hub', 0, 'https://hive.apache.org', 
  'bring-own', 1, 'hive.png', 'Big Data Queries', 'https://hive.apache.org');
INSERT INTO releases VALUES ('hive', 13, 'hive', 'Hive', '', 'soon', 1);
INSERT INTO versions VALUES ('hive', '0.229', '', 0, '20191115', '');

INSERT INTO projects VALUES ('hivefdw', 5, 0, 'hub', 0, 'https://github.com/bigsql/hive_fdw/releases', 
  'hive_fdw', 1, 'hive.png', 'Big Data Queries from PG', 'https://github.com/bigsql/hive_fdw#hive_fdw');
INSERT INTO releases VALUES ('hivefdw-pg11', 14, 'hivefdw', 'HiveFDW', '', 'test', 1);
INSERT INTO releases VALUES ('hivefdw-pg12', 14, 'hivefdw', 'HiveFDW', '', 'test', 1);
INSERT INTO versions VALUES ('hivefdw-pg11', '3.3.1-1', 'amd', 1, '20200222', 'pg11');
INSERT INTO versions VALUES ('hivefdw-pg12', '3.3.1-1', 'amd', 1, '20200222', 'pg12');

INSERT INTO projects VALUES ('mysql', 5, 0, 'hub', 0, 'https://dev.mysql.com/downloads/mysql', 
  'mysql', 0, 'mysql.png', 'MySQL Server CE', 'https://dev.mysql.com');
INSERT INTO releases VALUES ('mysql', 9, 'mysql', 'MySQL', '', 'soon',  1);
INSERT INTO versions VALUES ('mysql', '8.0.18', 'arm', 0, '20191014', '');

INSERT INTO projects VALUES ('mysqlfdw', 5, 0, 'hub', 0, 'https://github.com/EnterpriseDB/mysql_fdw/releases', 
  'mysqlfdw', 1, 'mysql_fdw.png', 'MySQL from PG', 'https://github.com/EnterpriseDb/mysql_fdw');
INSERT INTO releases VALUES ('mysqlfdw-pg11', 10, 'mysqlfdw', 'MySQL FDW',  '', 'prod', 1);
INSERT INTO releases VALUES ('mysqlfdw-pg12', 10, 'mysqlfdw', 'MySQL FDW',  '', 'prod', 1);
INSERT INTO versions VALUES ('mysqlfdw-pg11', '2.5.3-1', 'arm, amd', 1, '20190927', 'pg11');
INSERT INTO versions VALUES ('mysqlfdw-pg12', '2.5.3-1', 'arm, amd', 1, '20190927', 'pg12');

INSERT INTO projects VALUES ('sqlsvr', 5, 0, 'hub', 0, 'https://www.microsoft.com/en-us/sql-server/sql-server-2019',
  'sqlsvr', 0, 'sqlsvr.png', 'SQL Server 2019 for Linux', 'https://www.microsoft.com/en-us/sql-server/sql-server-2019');
INSERT INTO releases VALUES ('sqlsvr', 1, 'sqlsvr', 'SQL Server', '', 'soon',  0);
INSERT INTO versions VALUES ('sqlsvr', '2008+', 'amd', 0, '20191010', '');

INSERT INTO projects VALUES ('sybase', 5, 0, 'hub', 0, 'https://sap.com/products/sybase-ase.html', 
  'sybase', 0, 'sybase.png', 'Sybase ASE', 'https://sap.com/products/sybase-ase.html');
INSERT INTO releases VALUES ('sybase', 2, 'sybase',        'SAP Sybase ASE', '', 'soon',  0);
INSERT INTO versions VALUES ('sybase', '2019', 'amd', 0, '20191010', '');

INSERT INTO projects VALUES ('tdsfdw', 5, 0, 'hub', 0, 'https://github.com/tds-fdw/tds_fdw/releases',
  'tdsfdw', 1, 'tds.png', 'SQL Server & Sybase from PG', 'https://github.com/tds-fdw/tds_fdw/#tds-foreign-data-wrapper');
INSERT INTO releases VALUES ('tdsfdw-pg11', 4, 'tdsfdw', 'TDS FDW', '', 'prod', 1);
INSERT INTO releases VALUES ('tdsfdw-pg12', 4, 'tdsfdw', 'TDS FDW', '', 'prod', 1);
INSERT INTO versions VALUES ('tdsfdw-pg11', '2.0.1-1', 'amd',  1, '20191202', 'pg11');

INSERT INTO projects VALUES ('pgtop', 2, 0, 'hub', 0, 'https://gitlab.com/pg_top/pg_top/-/tags',
  'pgtop', 1, 'pgtop.png', '"top" for Postgres', 'https://gitlab.com/pg_top/pg_top/-/blob/master/README');
INSERT INTO releases VALUES ('pgtop-pg11', 8, 'pgtop', 'pgTop', '', 'prod', 1);
INSERT INTO releases VALUES ('pgtop-pg12', 8, 'pgtop', 'pgTop', '', 'prod', 1);
INSERT INTO versions VALUES ('pgtop-pg11', '3.7.0-1', 'arm, amd',  1, '20130731', 'pg11');
INSERT INTO versions VALUES ('pgtop-pg12', '3.7.0-1', 'arm, amd',  1, '20130731', 'pg12');

INSERT INTO projects VALUES ('esfdw', 5, 0, 'hub', 0, 'https://github.com/matthewfranglen/postgres-elasticsearch-fdw/releases',
  'esfdw', 1, 'elastic-search.png', 'Elastic Search from PG', 'https://github.com/matthewfranglen/postgres-elasticsearch-fdw#postgresql-elastic-search-foreign-data-wrapper');
INSERT INTO releases VALUES ('esfdw-pg11', 4, 'esfdw', 'Elastic Search FDW', '', 'soon', 1);
INSERT INTO releases VALUES ('esfdw-pg12', 4, 'esfdw', 'Elastic Search FDW', '', 'soon', 1);
INSERT INTO versions VALUES ('esfdw-pg11', '0.6.0-1', 'arm, amd',  1, '20200110', 'pg11');
INSERT INTO versions VALUES ('esfdw-pg12', '0.6.0-1', 'arm, amd',  1, '20200110', 'pg12');

INSERT INTO projects VALUES ('ora2pg', 2, 0, 'hub', 0, 'https://github.com/darold/ora2pg/releases',
  'ora2pg', 0, 'ora2pg.png', 'Migrate from Oracle to PG', 'https://ora2pg.darold.net');
INSERT INTO releases VALUES ('ora2pg', 7, 'ora2pg', 'Oracle to PG', '', 'prod', 0);
INSERT INTO versions VALUES ('ora2pg', '20.0', '', 1, '20190118', '');

INSERT INTO projects VALUES ('oraclefdw', 5, 0, 'hub', 0, 'https://github.com/laurenz/oracle_fdw/releases',
  'oraclefdw', 1, 'oracle_fdw.png', 'Oracle from PG', 'https://github.com/laurenz/oracle_fdw');
INSERT INTO releases VALUES ('oraclefdw-pg11', 7, 'oraclefdw', 'Oracle FDW', '', 'prod', 1);
INSERT INTO releases VALUES ('oraclefdw-pg12', 7, 'oraclefdw', 'Oracle FDW', '', 'prod', 1);
INSERT INTO versions VALUES ('oraclefdw-pg11','2.2.0-1', 'amd', 1, '20191010', 'pg11');
INSERT INTO versions VALUES ('oraclefdw-pg12','2.2.0-1', 'amd', 1, '20191010', 'pg12');

INSERT INTO projects VALUES ('oracle', 5, 0, 'hub', 0, 'https://www.oracle.com/downloads/licenses/database-11g-express-license.html', 
  'oracle', 0, 'oracle.png', 'Oracle 18c Express Edition', 'https://www.oracle.com/downloads/licenses/database-11g-express-license.html');
INSERT INTO releases VALUES ('oracle', 5, 'oracle', 'Oracle Database', '', 'soon',  0);
INSERT INTO versions VALUES ('oracle', '10+', 'amd', 0, '20191010', '');

-- ##
INSERT INTO categories VALUES (3, 'Procedures & Functions', 'Stored Procs');
INSERT INTO projects VALUES ('orafce', 3, 0, 'hub', 0, 'https://github.com/orafce/orafce/releases',
  'orafce', 1, 'larry.png', 'Ora Built-in Packages', 'https://github.com/orafce/orafce#orafce---oracles-compatibility-functions-and-packages');
INSERT INTO releases VALUES ('orafce-pg11', 6, 'orafce', 'OraFCE', '', 'prod', 1);
INSERT INTO releases VALUES ('orafce-pg12', 6, 'orafce', 'OraFCE', '', 'prod', 1);
INSERT INTO versions VALUES ('orafce-pg11', '3.9.0-1',  'arm, amd', 1, '20200213', 'pg11');
INSERT INTO versions VALUES ('orafce-pg12', '3.9.0-1',  'arm, amd', 1, '20200213', 'pg12');

INSERT INTO projects VALUES ('plv8', 3, 0, 'hub', 0, 'https://github.com/plv8/plv8/releases',
  'plv8',   1, 'v8.png', 'Javascript Stored Procedures', 'https://github.com/plv8/plv8');
INSERT INTO releases VALUES ('plv8-pg11', 4, 'plv8', 'PL/V8', '', 'soon', 1);
INSERT INTO versions VALUES ('plv8-pg11', '2.3.14-1', 'amd', 1, '20200109', 'pg11');

INSERT INTO projects VALUES ('plpython', 3, 0, 'hub', 0, 'https://www.postgresql.org/docs/11/plpython.html',
  'plpython', 1, 'python.png', 'Python3 Stored Procedures', 'https://www.postgresql.org/docs/11/plpython.html');
INSERT INTO releases VALUES ('plpython3', 4, 'plpython', 'PL/Python','', 'included', 1);
INSERT INTO versions VALUES ('plpython3', '3', 'arm, amd', 1, '20200213', 'pg11');

INSERT INTO projects VALUES ('plperl', 3, 0, 'hub', 0, 'https://www.postgresql.org/docs/11/plperl.html',
  'plperl', 1, 'perl.png', 'Perl Stored Procedures', 'https://www.postgresql.org/docs/11/plperl.html');
INSERT INTO releases VALUES ('plperl', 4, 'plperl', 'PL/Perl','', 'included', 1);
INSERT INTO versions VALUES ('plperl', '5', 'arm, amd', 1, '20200213', 'pg11');

INSERT INTO projects VALUES ('pljava', 3, 0, 'hub', 0, 'https://github.com/tada/pljava/releases', 
  'pljava', 1, 'pljava.png', 'Java Stored Procedures', 'https://github.com/tada/pljava');
INSERT INTO releases VALUES ('pljava-pg11', 4, 'pljava', 'PL/Java', '', 'soon', 1);
INSERT INTO releases VALUES ('pljava-pg12', 4, 'pljava', 'PL/Java', '', 'soon', 1);
INSERT INTO versions VALUES ('pljava-pg11', '1.5.5-1',  'amd',  1, '20191104', 'pg11');
INSERT INTO versions VALUES ('pljava-pg12', '1.5.5-1',  'amd',  1, '20191104', 'pg12');

INSERT INTO projects VALUES ('pldebugger', 3, 0, 'hub', 0, 'https://github.com/bigsql/pldebugger2/releases',
  'pldebugger', 1, 'debugger.png', 'Procedural Language Debugger', 'https://github.com/bigsql/pldebugger2#pldebugger2');
INSERT INTO releases VALUES ('pldebugger-pg11', 3, 'pldebugger', 'PL/Debugger', '', 'prod', 1);
INSERT INTO releases VALUES ('pldebugger-pg12', 3, 'pldebugger', 'PL/Debugger', '', 'prod', 1);
INSERT INTO versions VALUES ('pldebugger-pg11', '2.0-1',  'arm, amd',  1, '20200224', 'pg11');
INSERT INTO versions VALUES ('pldebugger-pg12', '2.0-1',  'arm, amd',  1, '20200224', 'pg12');

INSERT INTO projects VALUES ('plpgsql', 3, 0, 'hub', 0, 'https://github.com/pgsql/postgresql/releases',
  'plpgsql', 0, 'jan.png', 'Postgres Procedural Language', 'https://github.com/tada/pljava');
INSERT INTO releases VALUES ('plpgsql', 1, 'plpgsql', 'PL/pgSQL', '', 'included', 1);
INSERT INTO versions VALUES ('plpgsql', '12',  'arm, amd, osx',  1, '20200213', '');

INSERT INTO projects VALUES ('pgtsql', 3, 0, 'hub', 0, 'https://github.com/bigsql/pgtsql/releases',
  'pgtsql', 1, 'tds.png', 'Transact-SQL Procedures', 'https://github.com/bigsql/pgtsql#pgtsql');
INSERT INTO releases VALUES ('pgtsql-pg11', 3, 'pgtsql', 'PL/pgTSQL','', 'prod', 1);
INSERT INTO versions VALUES ('pgtsql-pg11', '3.0-1', 'arm, amd', 1, '20191119', 'pg11');

INSERT INTO projects VALUES ('plprofiler', 3, 0, 'hub', 7, 'https://github.com/bigsql/plprofiler/releases',
  'plprofiler', 1, 'plprofiler.png', 'Stored Procedure Profiler', 'https://github.com/bigsql/plprofiler#plprofiler');
INSERT INTO releases VALUES ('plprofiler-pg11', 2, 'plprofiler',    'PL/Profiler',  '', 'prod', 1);
INSERT INTO releases VALUES ('plprofiler-pg12', 2, 'plprofiler',    'PL/Profiler',  '', 'prod', 1);
INSERT INTO versions VALUES ('plprofiler-pg11', '4.1-1', 'arm, amd', 1, '20190823', 'pg11');
INSERT INTO versions VALUES ('plprofiler-pg12', '4.1-1', 'arm, amd', 1, '20190823', 'pg12');

INSERT INTO projects VALUES ('backrest', 2, 0, 'hub', 0, 'https://pgbackrest.org/release.html',
  'backrest', 0, 'backrest.png', 'Backup & Restore', 'https://pgbackrest.org');
INSERT INTO releases VALUES ('backrest', 9, 'backrest', 'pgBackRest', '', 'soon', 1);
INSERT INTO versions VALUES ('backrest', '2.24-1', 'arm, amd', 1, '20200225', '');

INSERT INTO projects VALUES ('audit', 2, 0, 'hub', 0, 'https://github.com/pgaudit/pgaudit/releases',
  'audit', 1, 'audit.png', 'Audit Logging', 'https://github.com/pgaudit/pgaudit');
INSERT INTO releases VALUES ('audit-pg11', 10, 'audit', 'pgAudit', '', 'prod', 1);
INSERT INTO releases VALUES ('audit-pg12', 10, 'audit', 'pgAudit', '', 'prod', 1);
INSERT INTO versions VALUES ('audit-pg11', '1.3.1-1', 'arm, amd', 1, '20190617', 'pg11');
INSERT INTO versions VALUES ('audit-pg12', '1.4.0-1', 'arm, amd', 1, '20190927', 'pg12');

INSERT INTO projects VALUES ('anon', 2, 0, 'hub',0, 'https://gitlab.com/dalibo/postgresql_anonymizer/releases',
  'anon', 1, 'anon.png', 'Anonymization & Masking', 'https://gitlab.com/dalibo/postgresql_anonymizer/blob/master/README.md');
INSERT INTO releases VALUES ('anon-pg11', 11, 'anon', 'Anonymizer', '', 'prod', 1);
INSERT INTO releases VALUES ('anon-pg12', 11, 'anon', 'Anonymizer', '', 'prod', 1);
INSERT INTO versions VALUES ('anon-pg11', '0.6.0-1', 'arm, amd', 1, '20200309', 'pg11');
INSERT INTO versions VALUES ('anon-pg12', '0.6.0-1', 'arm, amd', 1, '20200309', 'pg12');
INSERT INTO versions VALUES ('anon-pg11', '0.5.0-1', 'arm, amd', 0, '20191109', 'pg11');
INSERT INTO versions VALUES ('anon-pg12', '0.5.0-1', 'arm, amd', 0, '20191109', 'pg12');

INSERT INTO projects VALUES ('cron', 2, 0, 'hub',0, 'https://github.com/citusdata/pg_cron/releases',
  'cron', 1, 'cron.png', 'Scheduler as Background Worker', 'https://github.com/citusdata/pg_cron');
INSERT INTO releases VALUES ('cron-pg11', 5, 'cron', 'pgCron', '', 'prod', 1);
INSERT INTO releases VALUES ('cron-pg12', 5, 'cron', 'pgCron', '', 'prod', 1);
INSERT INTO versions VALUES ('cron-pg11', '1.2.0-1', 'arm, amd', 1, '20190830', 'pg11');
INSERT INTO versions VALUES ('cron-pg12', '1.2.0-1', 'arm, amd', 1, '20190830', 'pg12');

-- ##
INSERT INTO categories VALUES (2, 'Advanced Applications', 'Applics');

INSERT INTO projects VALUES ('timescaledb', 2, 0, 'hub', 1, 'https://github.com/timescale/timescaledb/releases',
   'timescaledb', 1, 'timescaledb.png', 'Time Series Data', 'https://github.com/timescale/timescaledb/#timescaledb');
INSERT INTO releases VALUES ('timescaledb-pg11',  1, 'timescaledb', 'TimescaleDB', '', 'prod', 1);
INSERT INTO versions VALUES ('timescaledb-pg11', '1.6.1-1',  'arm, amd', 1, '20200318', 'pg11');
INSERT INTO versions VALUES ('timescaledb-pg11', '1.6.0-1',  'arm, amd', 0, '20200115', 'pg11');

INSERT INTO projects VALUES ('pglogical', 2, 0, 'hub', 2, 'https://github.com/2ndQuadrant/pglogical/releases',
  'pglogical', 1, 'spock.png', 'pgLogical2 Replication', 'https://github.com/2ndQuadrant/pglogical');
INSERT INTO releases VALUES ('pglogical-pg11', 2, 'pglogical', 'pgLogical 2', '', 'prod', 1);
INSERT INTO releases VALUES ('pglogical-pg12', 2, 'pglogical', 'pgLogical 2', '', 'prod', 1);
INSERT INTO versions VALUES ('pglogical-pg11', '2.3.0-1',  'arm, amd', 1, '20200218', 'pg11');
INSERT INTO versions VALUES ('pglogical-pg12', '2.3.0-1',  'arm, amd', 1, '20200218', 'pg12');

INSERT INTO projects VALUES ('postgis', 2, 1, 'hub', 3, 'http://postgis.net/source',
  'postgis', 1, 'postgis.png', 'PostGIS', 'http://postgis.net');
INSERT INTO releases VALUES ('postgis-pg11', 3, 'postgis', 'PostGIS', '', 'prod', 1);
INSERT INTO releases VALUES ('postgis-pg12', 3, 'postgis', 'PostGIS', '', 'prod', 1);
INSERT INTO versions VALUES ('postgis-pg11', '3.0.1-1', 'amd', 1, '20200220', 'pg11');
INSERT INTO versions VALUES ('postgis-pg12', '3.0.1-1', 'amd', 1, '20200220', 'pg12');

INSERT INTO projects VALUES ('pgadmin', 2, 80, 'docker', 1, 'https://pgadmin.org',
  'pgadmin', 0, 'pgadmin.png', 'PG Admin for Docker', 'https://pgadmin.org');
INSERT INTO releases VALUES ('pgadmin', 3, 'pgadmin', 'pgAdmin', '', 'prod', 1);
INSERT INTO versions VALUES ('pgadmin', '4', '', 1, '20200305', '');

INSERT INTO projects VALUES ('bulkload', 2, 0, 'hub', 5, 'https://github.com/ossc-db/pg_bulkload/releases',
  'bulkload', 1, 'bulkload.png', 'High Speed Data Loading', 'https://github.com/ossc-db/pg_bulkload');
INSERT INTO releases VALUES ('bulkload-pg11', 6, 'bulkload', 'pgBulkLoad',  '', 'prod', 1);
INSERT INTO releases VALUES ('bulkload-pg12', 6, 'bulkload', 'pgBulkLoad',  '', 'prod', 1);
INSERT INTO versions VALUES ('bulkload-pg11', '3.1.16-1', 'amd', 1, '20200121', 'pg11');
INSERT INTO versions VALUES ('bulkload-pg12', '3.1.16-1', 'amd', 1, '20200121', 'pg12');

INSERT INTO projects VALUES ('repack', 2, 0, 'hub', 5, 'https://github.com/reorg/pg_repack/releases',
  'repack', 1, 'repack.png', 'Remove Table/Index Bloat' , 'https://github.com/reorg/pg_repack');
INSERT INTO releases VALUES ('repack-pg11', 6, 'repack', 'pgRepack',  '', 'prod', 1);
INSERT INTO releases VALUES ('repack-pg12', 6, 'repack', 'pgRepack',  '', 'prod', 1);
INSERT INTO versions VALUES ('repack-pg11', '1.4.5-1', 'arm, amd', 1, '20191004', 'pg11');
INSERT INTO versions VALUES ('repack-pg12', '1.4.5-1', 'arm, amd', 1, '20191004', 'pg12');

INSERT INTO projects VALUES ('partman', 2, 0, 'hub', 4, 'https://github.com/pgpartman/pg_partman/releases',
  'partman', 1, 'partman.png', 'Partition Managemnt', 'https://github.com/pgpartman/pg_partman#pg-partition-manager');
INSERT INTO releases VALUES ('partman-pg11', 6, 'partman', 'pgPartman',   '', 'prod', 1);
INSERT INTO releases VALUES ('partman-pg12', 6, 'partman', 'pgPartman',   '', 'prod', 1);
INSERT INTO versions VALUES ('partman-pg11', '4.3.0-1',  'arm, amd', 1, '20200206', 'pg11');
INSERT INTO versions VALUES ('partman-pg12', '4.3.0-1',  'arm, amd', 1, '20200206', 'pg12');

INSERT INTO projects VALUES ('hypopg', 2, 0, 'hub', 8, 'https://github.com/HypoPG/hypopg/releases',
  'hypopg', 1, 'whatif.png', 'Hypothetical Indexes', 'https://hypopg.readthedocs.io/en/latest/');
INSERT INTO releases VALUES ('hypopg-pg11', 7, 'hypopg', 'HypoPG', '', 'prod', 1);
INSERT INTO releases VALUES ('hypopg-pg12', 7, 'hypopg', 'HypoPG', '', 'prod', 1);
INSERT INTO versions VALUES ('hypopg-pg11', '1.1.3-1',  'arm, amd', 1, '20191123', 'pg11');
INSERT INTO versions VALUES ('hypopg-pg12', '1.1.3-1',  'arm, amd', 1, '20191123', 'pg12');

INSERT INTO projects VALUES ('pgbadger', 2, 0, 'hub', 6, 'https://github.com/darold/pgbadger/releases',
  'badger', 0, 'badger.png', 'Performance Reporting', 'https://pgbadger.darold.net');
INSERT INTO releases VALUES ('pgbadger', 8, 'pgbadger','pgBadger','', 'prod', 1);
INSERT INTO versions VALUES ('pgbadger', '11.2', '', 1, '20200311', '');
INSERT INTO versions VALUES ('pgbadger', '11.1', '', 0, '20190916', '');

INSERT INTO projects VALUES ('bouncer', 2, 0, 'hub', 3, 'http://pgbouncer.org',
  'bouncer',  1, 'bouncer.png', 'Lightweight Connection Pooler', 'http://pgbouncer.org');
INSERT INTO releases VALUES ('bouncer-pg11', 5, 'bouncer',  'pgBouncer', '', 'prod', 1);
INSERT INTO releases VALUES ('bouncer-pg12', 5, 'bouncer',  'pgBouncer', '', 'prod', 1);
INSERT INTO versions VALUES ('bouncer-pg11', '1.12.0-1', 'arm, amd', 1, '20191017', 'pg11');
INSERT INTO versions VALUES ('bouncer-pg12', '1.12.0-1', 'arm, amd', 1, '20191017', 'pg12');

INSERT INTO projects VALUES ('agent', 2, 0, 'hub', 3, 'http://github.com/postgres/pgagent/releases',
  'agent',  0, 'agent.png', 'Job Scheduler for pgAdmin4', 'http://github.com/postgres/pgagent');
INSERT INTO releases VALUES ('agent', 4, 'agent',  'pgAgent', '', 'included', 1);
INSERT INTO versions VALUES ('agent', '4.0.0', 'amd', 1, '20180712', '');

-- ##
INSERT INTO categories VALUES (4, 'Container Technologies', 'Containers');

INSERT INTO projects VALUES ('docker', 4, 0, 'hub', 1, 'https://github.com/docker/docker-ce/releases', 'docker', 0, 'docker.png', 'Container Runtime', 'https://github.com/docker/docker-ce/#docker-ce');
INSERT INTO releases VALUES ('docker', 1, 'docker', 'Docker CE', '', 'test', 1);
INSERT INTO versions VALUES ('docker', '19', '', 1, '20200303', '');

INSERT INTO projects VALUES ('minikube', 4, 0, 'hub', 2, 'https://github.com/kubernetes/minikube/releases', 'minikube', 0, 'minikube.png', 'Kubernetes (MiniKube)', 'https://minikube.sigs.k8s.io/');
INSERT INTO releases VALUES ('minikube', 2, 'minikube', 'Local Kubernetes', '', 'bring-own', 1);
INSERT INTO versions VALUES ('minikube', '1.8.2', '', 1, '20200313', '');

INSERT INTO projects VALUES ('helm', 4, 0, 'hub', 3, 'https://github.com/helm/helm/releases', 'helm', 0, 'helm.png', 'K8s Package Manager', 'https://helm.sh');
INSERT INTO releases VALUES ('helm', 3, 'helm', 'Helm', '', 'bring-own', 1);
INSERT INTO versions VALUES ('helm', '3.1.2', '', 1, '20200311', '');

-- ##
INSERT INTO categories VALUES (7, 'PGSQL Developers Toolchain', 'Toolchain');

INSERT INTO projects VALUES ('brew', 7, 0, 'hub', 4, 'https://github.com/homebrew/brew/releases',
  'brew', 0, 'homebrew.png', 'OSX GNU toolchain', 'https://brew.sh');
INSERT INTO releases VALUES ('brew', 5, 'brew', 'Homebrew', '', 'bring-own', 1);
INSERT INTO versions VALUES ('brew', '2.2.10', '', 1, '20200308', '');

INSERT INTO projects VALUES ('patroni', 4, 0, 'hub', 4, 'https://github.com/zalando/patroni/releases',
  'patroni', 0, 'patroni.png', 'HA Template', 'https://github.com/zalando/patroni');
INSERT INTO releases VALUES ('patroni', 4, 'patroni', 'Patroni', '', 'bring-own', 1);
INSERT INTO versions VALUES ('patroni', '1.6.4', '', 1, '20200127', '');

INSERT INTO projects VALUES ('llvm', 7, 0, 'hub', 3, 'https://releases.llvm.org', 
  'llvm', 0, 'llvm.png', 'Just in Time Compilation', 'https://llvm.org');
INSERT INTO releases VALUES ('llvm', 5, 'llvm', 'LLVM', '', 'bring-own', 1);
INSERT INTO versions VALUES ('llvm', '9.0.1', '', 1, '20191220', '');

INSERT INTO projects VALUES ('bison', 7, 0, 'hub', 4, 'http://ftp.gnu.org/gnu/bison/',
  'bison', 0, 'gnu.png', 'Parser-Generator', 'https://gnu.org/software/bison/');
INSERT INTO releases VALUES ('bison', 6, 'bison', 'Bison', '', 'bring-own', 1);
INSERT INTO versions VALUES ('bison', '3.5.3', '', 1, '20200308', '');

INSERT INTO projects VALUES ('gcc', 7, 0, 'hub', 4, 'http://ftp.gnu.org/gnu/gcc/',
  'gcc', 0, 'gcc.png', 'the GNU Compiler Collection', 'https://gnu.org/software/gcc/');
INSERT INTO releases VALUES ('gcc', 6, 'gcc', 'GCC', '', 'bring-own', 1);
INSERT INTO versions VALUES ('gcc', '9.3.0', '', 1, '20200312', '');

INSERT INTO projects VALUES ('valgrind', 7, 0, 'hub', 4, 'http://valgrind.org',
  'valgrind', 0, 'valgrind.png', 'Memory Checker & Profiler', 'http://valgrind.org');
INSERT INTO releases VALUES ('valgrind', 8, 'valgrind', 'Valgrind', '', 'bring-own', 1);
INSERT INTO versions VALUES ('valgrind', '3.15.0', '', 1, '20190414', '');

INSERT INTO projects VALUES ('gdb', 7, 0, 'hub', 4, 'http://ftp.gnu.org/gnu/gdb/',
  'gdb', 0, 'gdb.png', 'the GNU Debugger', 'https://gnu.org/software/gdb/');
INSERT INTO releases VALUES ('gdb', 7, 'gdb', 'GDB', '', 'bring-own', 1);
INSERT INTO versions VALUES ('gdb', '9.2.0', '', 1, '20190812', '');

-- ##
INSERT INTO categories VALUES (8, 'Connectors',   'Applications');
INSERT INTO projects VALUES ('omnidb', 2, 8000, 'docker', 2, 'https://github.com/omnidb/omnidb/releases', 'omnidb', 0, 'omnidb.png', 'RDBMS Web Admin', 'https://github.com/omnidb/omnidb/#omnidb');
INSERT INTO releases VALUES ('omnidb', 11, 'omnidb', 'OmniDB', '', 'bring-own', 1);
INSERT INTO versions VALUES ('omnidb', '2.17-1', '', 1, '20191205', '');

INSERT INTO projects VALUES ('jdbc', 8, 0, 'hub', 1, 'https://jdbc.postgresql.org', 'jdbc', 0, 'java.png', 'JDBC Driver', 'https://jdbc.postgresql.org');
INSERT INTO releases VALUES ('jdbc', 7, 'jdbc', 'JDBC', '', 'bring-own', 1);
INSERT INTO versions VALUES ('jdbc', '42.2.10', '', 1, '20200130', '');

INSERT INTO projects VALUES ('npgsql', 8, 0, 'hub', 2, 'https://www.nuget.org/packages/Npgsql/', 'npgsql', 0, 'npgsql.png', '.NET Provider', 'https://www.npgsql.org');
INSERT INTO releases VALUES ('npgsql', 10, 'npgsql', '.net PG', '', 'bring-own', 1);
INSERT INTO versions VALUES ('npgsql', '4.1.3.1', '', 1, '20200220', '');

INSERT INTO projects VALUES ('psycopg', 8, 0, 'hub', 3, 'https://pypi.org/project/psycopg2/', 'psycopg', 0, 'psycopg.png', 'Python Adapter', 'http://psycopg.org');
INSERT INTO releases VALUES ('psycopg', 6, 'psycopg', 'Psycopg', '', 'bring-own', 1);
INSERT INTO versions VALUES ('psycopg', '2.8.4', '', 1, '20191020', '');

INSERT INTO projects VALUES ('ruby', 8, 0, 'hub', 4, 'https://rubygems.org/gems/pg', 'ruby', 0, 'ruby.png', 'Ruby Interface', 'https://github.com');
INSERT INTO releases VALUES ('ruby', 7, 'ruby', 'Ruby', '', 'bring-own', 1);
INSERT INTO versions VALUES ('ruby', '1.2.2', '', 1, '20200108', '');

INSERT INTO projects VALUES ('odbc', 8, 0, 'hub', 5, 'https://www.postgresql.org/ftp/odbc/versions/msi/', 'odbc', 0, 'odbc.png', 'ODBC Driver', 'https://odbc.postgresql.org');
INSERT INTO releases VALUES ('odbc', 8, 'odbc',  'ODBC', '', 'soon', 1);
INSERT INTO versions VALUES ('odbc', '12.01-1', 'arm, amd', 1, '20200107', '');

INSERT INTO projects VALUES ('http', 3, 0, 'hub', 6, 'https://github.com/pramsey/pgsql-http/releases', 'http',  1, 'http.png', 'Invoke Web Services', 'https://github.com/pramsey/pgsql-http');
INSERT INTO releases VALUES ('http-pg11', 13, 'http', 'HTTP Client', '', 'prod', 1);
INSERT INTO releases VALUES ('http-pg12', 13, 'http', 'HTTP Client', '', 'prod', 1);
INSERT INTO versions VALUES ('http-pg11', '1.3.1-1', 'arm, amd', 1, '20191225', 'pg11');
INSERT INTO versions VALUES ('http-pg12', '1.3.1-1', 'arm, amd', 1, '20191225', 'pg12');

INSERT INTO projects VALUES ('pgrest',     8, 0, 'hub', 3, 'https://github.com/pgrest/pgrest/releases', 'pgrest', 0, 'restapi.png', 'RESTFUL API', 'https://github.com/pgrest/pgrest');
INSERT INTO releases VALUES ('pgrest', 9, 'pgrest', 'Data API', '', 'bring-own', 1);
INSERT INTO versions VALUES ('pgrest', '0.0.7-1', '', 1, '20130813', '');

INSERT INTO projects VALUES ('ddlx',      7, 0, 'hub', 4, 'https://github.com/lacanoid/pgddl/releases', 'ddlx',  1, 'ddlx.png', 'DDL Extractor', 'https://github.com/lacanoid/pgddl#ddl-extractor-functions--for-postgresql');
INSERT INTO releases VALUES ('ddlx-pg11', 9, 'ddlx', 'DDLeXtact', '', 'test', 0);
INSERT INTO releases VALUES ('ddlx-pg12', 9, 'ddlx', 'DDLeXtact', '', 'test', 0);
INSERT INTO versions VALUES ('ddlx-pg11', '0.16-1', 'arm, amd', 1, '20191110', 'pg11');
INSERT INTO versions VALUES ('ddlx-pg12', '0.16-1', 'arm, amd', 1, '20191110', 'pg12');

INSERT INTO projects VALUES ('multicorn', 7, 0, 'hub', 4, 'https://github.com/Segfault-Inc/Multicorn/releases',
  'multicorn', 1, 'multicorn.png', 'Python FDW Library', 'http://multicorn.org');
INSERT INTO releases VALUES ('multicorn-pg11', 10, 'multicorn', 'Multicorn', '', 'test', 1);
INSERT INTO releases VALUES ('multicorn-pg12', 10, 'multicorn', 'Multicorn', '', 'test', 1);
INSERT INTO versions VALUES ('multicorn-pg11', '1.4.0-1', 'arm, amd', 1, '20200318', 'pg11');
INSERT INTO versions VALUES ('multicorn-pg12', '1.4.0-1', 'arm, amd', 1, '20200318', 'pg12');
