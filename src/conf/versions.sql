DROP VIEW  IF EXISTS v_versions;

DROP TABLE IF EXISTS versions;
DROP TABLE IF EXISTS releases;
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS families;

CREATE TABLE families (
  family      INTEGER NOT NULL PRIMARY KEY,
  description TEXT,
  short_desc  TEXT,
  image       TEXT
);

CREATE TABLE categories (
  category    INTEGER NOT NULL PRIMARY KEY,
  family      INTEGER NOT NULL REFERENCES families(family),
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
INSERT INTO families VALUES (10, '_', '_', '_');
INSERT INTO categories VALUES (0, 10,  'Hidden', 'NotShown');
INSERT INTO projects VALUES ('hub',0, 0, 'hub', 0, 'https://github.com/','',0,'','','');
INSERT INTO releases VALUES ('hub', 1, 'hub', '', '', 'hidden', 1);
INSERT INTO versions VALUES ('hub', '6.0', '', 1, '20200213', '');

-- ##
INSERT INTO families  VALUES (20, 'Worlds Most Advanced Open Source Database', 'Best RDBMS', 'postgres.png');
INSERT INTO categories VALUES (1, 20, 'Worlds Best RDBMS', 'Postgres');

INSERT INTO projects VALUES ('pg', 1, 5432, 'hub', 1, 'https://postgresql.org/download',
 'postgres', 0, 'bruce.png', 'Best RDBMS', 'https://postgresql.org');

INSERT INTO releases VALUES ('pg10', 2, 'pg', 'PostgreSQL', '', 'prod', 1);
INSERT INTO versions VALUES ('pg10', '10.12-1', 'arm, amd, osx', 1, '20200213','');
INSERT INTO versions VALUES ('pg10', '10.11-7', 'arm, amd, osx', 0, '20191114','');

INSERT INTO releases VALUES ('pg11', 3, 'pg', 'PostgreSQL', '', 'prod', 1);
INSERT INTO versions VALUES ('pg11', '11.7-1', 'arm, amd, osx', 1, '20200213','');
INSERT INTO versions VALUES ('pg11', '11.6-7', 'arm, amd, osx', 0, '20191114','');

INSERT INTO releases VALUES ('pg12', 4, 'pg', 'PostgreSQL', '', 'prod', 1);
INSERT INTO versions VALUES ('pg12', '12.2-1', 'arm, amd, osx', 1, '20200213','');
INSERT INTO versions VALUES ('pg12', '12.1-7', 'arm, amd, osx', 0, '20191114','');

INSERT INTO releases VALUES ('pgweekly', 5, 'pg', 'PostgreSQL Weekly Build', '', 'soon', 1);
INSERT INTO versions VALUES ('pgweekly', '13', 'arm, amd, osx', 0, '19700101','');

-- ##
INSERT INTO families VALUES (30, 'Compatability, Migration & Interoperability', 'Compatible', 'plug_compat.png');
INSERT INTO categories VALUES (5, 30, 'Foreign Data Integration', 'Foreign Data');

INSERT INTO projects VALUES ('cassandra', 5, 0, 'hub', 0, 'https://cassandra.apache.org', 'cassandra', 0, 'cstar.png', 'Multi-Master Big Data', 'https://cassandra.apache.org');
INSERT INTO releases VALUES ('cassandra', 11, 'cassandra','Cassandra', '', 'soon', 1);
INSERT INTO versions VALUES ('cassandra', '3.11.5', '', 1, '20191029', '');

INSERT INTO projects VALUES ('cassandra_fdw', 5, 0, 'hub', 0, 'https://github.com/bigsql/cassandra_fdw/releases', 
  'cstarfdw', 1, 'cstar_fdw.png', 'Cassandra from PG', 'https://github.com/bigsql/cassandra_fdw#cassandra_fdw');
INSERT INTO releases VALUES ('cassandra_fdw-pg11', 12, 'cassandra_fdw', 'CassandraFDW','','soon', 1);
INSERT INTO versions VALUES ('cassandra_fdw-pg11', '3.1.5-1', 'arm', 1, '20191230', 'pg11');

INSERT INTO projects VALUES ('hive', 5, 0, 'hub', 0, 
  'https://hive.apache.org', 'bring-own', 1, 'hive.png', 
  'Big Data Queries', 'https://hive.apache.org');
INSERT INTO releases VALUES ('hive', 13, 'hive', 'Hive', '', 'soon', 1);
INSERT INTO versions VALUES ('hive', '0.229', '', 1, '20191115', '');

INSERT INTO projects VALUES ('hive_fdw', 5, 0, 'hub', 0, 
  'https://github.com/bigsql/hive_fdw/releases', 'hive_fdw', 1, 'hive_fdw.png', 
  'Big Data Queries from PG', 'https://github.com/bigsql/pghivew#pghive');
INSERT INTO releases VALUES ('hive_fdw-pg11', 14, 'hive_fdw', 'Hive FDW', '', 'soon', 1);
INSERT INTO versions VALUES ('hive_fdw-pg11', '3.2-1', 'arm', 1, '20191230', 'pg11');

INSERT INTO projects VALUES ('mysql', 5, 0, 'hub', 0, 
  'https://dev.mysql.com/downloads/mysql', 'mysql', 0, 'mysql.png',
  'MySQL Server CE', 'https://dev.mysql.com');
INSERT INTO releases VALUES ('mysql', 9, 'mysql', 'MySQL', '', 'soon',  1);
INSERT INTO versions VALUES ('mysql', '8.0.18', 'arm', 1, '20191014', '');

INSERT INTO projects VALUES ('mysql_fdw', 5, 0, 'hub', 0, 
  'https://github.com/EnterpriseDB/mysql_fdw/releases', 'mysql_fdw', 1, 'mysql_fdw.png', 
  'MySQL from PG', 'https://github.com/EnterpriseDb/mysql_fdw');
INSERT INTO releases VALUES ('mysql_fdw-pg11', 10, 'mysql_fdw', 'MySQL FDW',  '', 'soon', 1);
INSERT INTO versions VALUES ('mysql_fdw-pg11', '2.5.3-1', 'arm', 1, '20190927', 'pg11');

INSERT INTO projects VALUES ('sqlsvr', 5, 0, 'hub', 0, 'https://www.microsoft.com/en-us/sql-server/sql-server-2019', 'sqlsvr', 0, 'sqlsvr.png', 'SQL Server 2019 for Linux', 'https://www.microsoft.com/en-us/sql-server/sql-server-2019');
INSERT INTO releases VALUES ('sqlsvr', 1, 'sqlsvr', 'SQL Server', '', 'soon',  0);
INSERT INTO versions VALUES ('sqlsvr', '2008+', 'amd', 1, '20191010', '');

INSERT INTO projects VALUES ('sybase', 5, 0, 'hub', 0, 'https://sap.com/products/sybase-ase.html', 'sybase', 0, 'sybase.png', 'Sybase ASE', 'https://sap.com/products/sybase-ase.html');
INSERT INTO releases VALUES ('sybase', 2, 'sybase',        'SAP Sybase ASE', '', 'soon',  0);
INSERT INTO versions VALUES ('sybase', '2019', 'amd', 1, '20191010', '');

INSERT INTO projects VALUES ('tds_fdw', 5, 0, 'hub', 0, 'https://github.com/tds-fdw/tds_fdw/releases', 'tds_fdw', 1, 'tds.png', 'SQL Server & Sybase from PG', 'https://github.com/tds-fdw/tds_fdw/#tds-foreign-data-wrapper');
INSERT INTO releases VALUES ('tds_fdw-pg11', 4, 'tds_fdw', 'TDS FDW', '', 'soon', 1);
INSERT INTO versions VALUES ('tds_fdw-pg11', '2.0.1-1', 'arm',  1, '20191202', 'pg11');

INSERT INTO projects VALUES ('ora2pg', 5, 0, 'hub', 0, 'https://github.com/darold/ora2pg/releases', 'ora2pg', 1, 'ora2pg.png', 'Migrate from Oracle to PostgreSQL', 'https://ora2pg.darold.net');
INSERT INTO releases VALUES ('ora2pg', 7, 'ora2pg', 'Oracle to Postgres', '', 'soon', 0);
INSERT INTO versions VALUES ('ora2pg', '20.0', '', 1, '20190118', '');

INSERT INTO projects VALUES ('oracle_fdw', 5, 0, 'hub', 0, 'https://github.com/laurenz/oracle_fdw/releases', 'oracle_fdw', 1, 'oracle_fdw.png', 'Oracle from PG', 'https://github.com/laurenz/oracle_fdw');
INSERT INTO releases VALUES ('oracle_fdw-pg11', 7, 'oracle_fdw', 'Oracle FDW', '', 'soon', 1);
INSERT INTO versions VALUES ('oracle_fdw-pg11','2.2.0-1', 'amd', 1, '20191010', 'pg11');

INSERT INTO projects VALUES ('oracle', 5, 0, 'hub', 0, 'https://www.oracle.com/downloads/licenses/database-11g-express-license.html', 'oracle', 0, 'oracle.png', 'Oracle 18c Express Edition', 'https://www.oracle.com/downloads/licenses/database-11g-express-license.html');
INSERT INTO releases VALUES ('oracle', 5, 'oracle', 'Oracle Database', '', 'soon',  0);
INSERT INTO versions VALUES ('oracle', '10+', 'amd', 1, '20191010', '');

-- ##
 INSERT INTO categories VALUES (3, 30, 'Procedures & Functions', 'Stored Procs');

 INSERT INTO projects VALUES ('orafce', 3, 0, 'hub', 0, 'https://github.com/orafce/orafce/releases', 'orafce', 1, 'larry.png', 'Ora Built-in Packages', 'https://github.com/orafce/orafce#orafce---oracles-compatibility-functions-and-packages');
  INSERT INTO releases VALUES ('orafce-pg11', 6, 'orafce', 'OraFCE', '', 'prod', 1);
  INSERT INTO releases VALUES ('orafce-pg12', 6, 'orafce', 'OraFCE', '', 'prod', 1);
   INSERT INTO versions VALUES ('orafce-pg11', '3.8.0-1',  'arm, amd', 1, '20190522', 'pg11');
   INSERT INTO versions VALUES ('orafce-pg12', '3.8.0-1',  'arm, amd', 1, '20190522', 'pg12');

INSERT INTO projects VALUES ('plv8', 3, 0, 'hub', 0, 'https://github.com/plv8/plv8/releases', 'plv8',   1, 'v8.png', 'Javascript Stored Procedures', 'https://github.com/plv8/plv8');
INSERT INTO releases VALUES ('plv8-pg11', 4, 'plv8', 'PL/V8', '', 'soon', 1);
INSERT INTO versions VALUES ('plv8-pg11', '2.3.14-1', 'arm', 1, '20200109', 'pg11');

INSERT INTO projects VALUES ('plpython', 3, 0, 'hub', 0, 'https://www.postgresql.org/docs/11/plpython.html', 'plpython', 1, 'python.png', 'Python3 Stored Procedures', 'https://www.postgresql.org/docs/11/plpython.html');
INSERT INTO releases VALUES ('plpython-pg11', 4, 'plpython', 'PL/Python','', 'included', 1);
INSERT INTO versions VALUES ('plpython-pg11', '3', 'arm, amd', 1, '20191114', 'pg11');

 INSERT INTO projects VALUES ('plperl', 3, 0, 'hub', 0, 'https://www.postgresql.org/docs/11/plperl.html', 'plperl', 1, 'perl.png', 'Perl Stored Procedures', 'https://www.postgresql.org/docs/11/plperl.html');
  INSERT INTO releases VALUES ('plperl-pg11', 4, 'plperl', 'PL/Perl','', 'included', 1);
   INSERT INTO versions VALUES ('plperl-pg11', '5', 'arm, amd', 1, '20191114', 'pg11');

 INSERT INTO projects VALUES ('pljava', 3, 0, 'hub', 0, 'https://github.com/tada/pljava/releases', 'pljava', 1, 'java.png', 'Java Stored Procedures', 'https://github.com/tada/pljava');
  INSERT INTO releases VALUES ('pljava-pg11', 4, 'pljava', 'PL/Java', '', 'soon', 1);
   INSERT INTO versions VALUES ('pljava-pg11', '1.5.5-1',  'arm',  1, '20191104', 'pg11');

 INSERT INTO projects VALUES ('pldebugger', 3, 0, 'hub', 0, 'https://github.com/pgsql/postgresql/releases', 'pldebugger', 1, 'debugger.png', 'Procedural Language Debugger', 'https://github.com/tada/pljava');
  INSERT INTO releases VALUES ('pldebugger-pg11', 3, 'pldebugger', 'PL/Debugger', '', 'soon', 1);
   INSERT INTO versions VALUES ('pldebugger-pg11', '2',  'arm',  1, '20191114', 'pg11');

 INSERT INTO projects VALUES ('plpgsql', 3, 0, 'hub', 0, 'https://github.com/pgsql/postgresql/releases', 'plpgsql', 1, 'jan.png', 'Postgres Procedural Language', 'https://github.com/tada/pljava');
  INSERT INTO releases VALUES ('plpgsql-pg11', 1, 'plpgsql', 'PL/pgSQL', '', 'included', 1);
   INSERT INTO versions VALUES ('plpgsql-pg11', '12',  'arm, amd, osx',  1, '20191114', 'pg11');

  INSERT INTO projects VALUES ('pgosql', 3, 0, 'hub', 0, 'https://github.com/bigsql/pgosql/releases', 'pgosql', 1, 'sailboat.png', 'PL/SQL Procedures', 'https://github.com/bigsql/pgosql#pgosql');
   INSERT INTO releases VALUES ('pgosql-pg11', 8, 'pgosql', 'pgOSQL', '', 'soon', 1);
    INSERT INTO versions VALUES ('pgosql-pg11', '2.0-1', 'arm', 1, '20191211', 'pg11');

  INSERT INTO projects VALUES ('pgtsql', 3, 0, 'hub', 0, 'https://github.com/bigsql/pgtsql/releases', 'pgtsql', 1, 'tds.png', 'Transact-SQL Procedures', 'https://github.com/bigsql/pgtsql#pgtsql');
   INSERT INTO releases VALUES ('pgtsql-pg11', 3, 'pgtsql', 'pgTSQL','', 'prod', 1);
    INSERT INTO versions VALUES ('pgtsql-pg11', '3.0-1', 'arm, amd', 1, '20191119', 'pg11');

  INSERT INTO projects VALUES ('plprofiler', 3, 0, 'hub', 7, 'https://github.com/bigsql/plprofiler/releases', 'plprofiler', 1, 'plprofiler.png', 'Stored Procedure Profiler', 'https://github.com/bigsql/plprofiler#plprofiler');
   INSERT INTO releases VALUES ('plprofiler-pg11', 2, 'plprofiler',    'plProfiler',  '', 'prod', 1);
   INSERT INTO releases VALUES ('plprofiler-pg12', 2, 'plprofiler',    'plProfiler',  '', 'prod', 1);
    INSERT INTO versions VALUES ('plprofiler-pg11', '4.1-1', 'arm, amd', 1, '20190823', 'pg11');
    INSERT INTO versions VALUES ('plprofiler-pg12', '4.1-1', 'arm, amd', 1, '20190823', 'pg12');

-- ##
INSERT INTO families VALUES (40, 'Security, Scalability & Availability', 'Capable', 'ability.png');
 INSERT INTO categories VALUES (4, 40,'Security', 'Secure');

  INSERT INTO projects VALUES ('backrest', 4, 0, 'hub', 0, 'https://pgbackrest.org/release.html', 'backrest', 0, 'backrest.png', 'Backup & Restore', 'https://pgbackrest.org');
   INSERT INTO releases VALUES ('backrest', 4, 'backrest', 'pgBackRest', '', 'included', 1);
    INSERT INTO versions VALUES ('backrest', '2.23-1', 'arm, amd', 1, '20200127', '');

  INSERT INTO projects VALUES ('audit', 4, 0, 'hub', 0, 'https://github.com/pgaudit/pgaudit/releases', 'audit', 1, 'audit.png', 'Audit Logging', 'https://github.com/pgaudit/pgaudit');
   INSERT INTO releases VALUES ('audit-pg11', 10, 'audit', 'pgAudit', '', 'prod', 1);
   INSERT INTO releases VALUES ('audit-pg12', 10, 'audit', 'pgAudit', '', 'prod', 1);
    INSERT INTO versions VALUES ('audit-pg11', '1.3.1-1', 'arm, amd', 1, '20190617', 'pg11');
    INSERT INTO versions VALUES ('audit-pg12', '1.4.0-1', 'arm, amd', 1, '20190927', 'pg12');

  INSERT INTO projects VALUES ('anon', 4, 0, 'ddlx',0, 'https://gitlab.com/dalibo/postgresql_anonymizer/releases', 'anon', 1, 'anon.png', 'Anonymization & Masking', 'https://gitlab.com/dalibo/postgresql_anonymizer/blob/master/README.md');
   INSERT INTO releases VALUES ('anon-pg11', 11, 'anon', 'Anonymizer', '', 'prod', 1);
   INSERT INTO releases VALUES ('anon-pg12', 11, 'anon', 'Anonymizer', '', 'prod', 1);
    INSERT INTO versions VALUES ('anon-pg11', '0.5.0-1', 'arm, amd', 1, '20191109', 'pg11');
    INSERT INTO versions VALUES ('anon-pg12', '0.5.0-1', 'arm, amd', 1, '20191109', 'pg12');

-- ##
 INSERT INTO categories VALUES (2, 40, 'Scalability', 'Scalable');

  INSERT INTO projects VALUES ('timescaledb', 2, 0, 'hub', 1, 'https://github.com/timescale/timescaledb/releases', 'timescaledb', 1, 'timescaledb.png', 'Time Series Data', 'https://github.com/timescale/timescaledb/#timescaledb');
   INSERT INTO releases VALUES ('timescaledb-pg11',  1, 'timescaledb', 'TimescaleDB', '', 'prod', 1);
    INSERT INTO versions VALUES ('timescaledb-pg11', '1.5.1-1',  'arm, amd', 0, '20191112', 'pg11');
    INSERT INTO versions VALUES ('timescaledb-pg11', '1.6.0-1',  'arm, amd', 1, '20200115', 'pg11');

  INSERT INTO projects VALUES ('spock', 2, 0, 'hub', 2, 'https://github.com/bigsql/spock/releases', 'spock', 1, 'spock.png', 'Logical Streaming Replication', 'https://github.com/bigsql/spock');
   INSERT INTO releases VALUES ('spock-pg11', 2, 'spock', 'Spock', '', 'prod', 1);
    INSERT INTO versions VALUES ('spock-pg11', '2.2.3-1',  'arm, amd', 1, '20200213', 'pg11');

  INSERT INTO projects VALUES ('postgis', 2, 1, 'hub', 3, 'http://postgis.net', 'postgis', 0, 'postgis.png', 'PostGIS', 'http://postgis.net');
   INSERT INTO releases VALUES ('postgis-pg12', 3, 'postgis', 'PostGIS', '', 'soon', 1);
   INSERT INTO versions VALUES ('postgis-pg12', '3.0.0', 'arm, amd, osx', 1, '20191020', 'pg12');

  INSERT INTO projects VALUES ('bulkload', 2, 0, 'hub', 5, 'https://github.com/ossc-db/pg_bulkload/releases', 'bulkload', 1, 'bulkload.png', 'High Speed Data Loading', 'https://github.com/ossc-db/pg_bulkload');
   INSERT INTO releases VALUES ('bulkload-pg11', 4, 'bulkload', 'pgBulkLoad',  '', 'prod', 1);
   INSERT INTO releases VALUES ('bulkload-pg12', 4, 'bulkload', 'pgBulkLoad',  '', 'prod', 1);
    INSERT INTO versions VALUES ('bulkload-pg11', '3.1.15-1', 'arm, amd', 0, '20190120', 'pg11');
    INSERT INTO versions VALUES ('bulkload-pg11', '3.1.16-1', 'arm, amd', 1, '20200121', 'pg11');
    INSERT INTO versions VALUES ('bulkload-pg12', '3.1.16-1', 'arm, amd', 1, '20200121', 'pg12');

  INSERT INTO projects VALUES ('repack', 2, 0, 'hub', 5, 'https://github.com/reorg/pg_repack/releases', 'repack', 1, 'repack.png', 'Compress Tables via Re-org', 'https://github.com/reorg/pg_repack');
   INSERT INTO releases VALUES ('repack-pg11', 5, 'repack', 'pgRepack',  '', 'soon', 1);
    INSERT INTO versions VALUES ('repack-pg11', '1.4.5', 'arm, amd', 1, '20191004', 'pg11');

  INSERT INTO projects VALUES ('partman', 2, 0, 'hub', 4, 'https://github.com/pgpartman/pg_partman/releases', 'partman', 1, 'partman.png', 'Partition Managemnt', 'https://github.com/pgpartman/pg_partman#pg-partition-manager');
   INSERT INTO releases VALUES ('partman-pg11', 6, 'partman', 'pgPartman',   '', 'prod', 1);
   INSERT INTO releases VALUES ('partman-pg12', 6, 'partman', 'pgPartman',   '', 'prod', 1);
    INSERT INTO versions VALUES ('partman-pg11', '4.2.2-1',  'arm, amd', 0, '20191016', 'pg11');
    INSERT INTO versions VALUES ('partman-pg11', '4.3.0-1',  'arm, amd', 1, '20200206', 'pg11');
    INSERT INTO versions VALUES ('partman-pg12', '4.3.0-1',  'arm, amd', 1, '20200206', 'pg12');

  INSERT INTO projects VALUES ('hypopg', 2, 0, 'hub', 8, 'https://github.com/HypoPG/hypopg/releases', 'hypopg', 1, 'whatif.png', 'Hypothetical Indexes', 'https://hypopg.readthedocs.io/en/latest/');
   INSERT INTO releases VALUES ('hypopg-pg11', 7, 'hypopg', 'HypoPG', '', 'prod', 1);
   INSERT INTO releases VALUES ('hypopg-pg12', 7, 'hypopg', 'HypoPG', '', 'prod', 1);
    INSERT INTO versions VALUES ('hypopg-pg11', '1.1.3-1',  'arm, amd', 1, '20191123', 'pg11');
    INSERT INTO versions VALUES ('hypopg-pg12', '1.1.3-1',  'arm, amd', 1, '20191123', 'pg12');

  INSERT INTO projects VALUES ('badger', 2, 0, 'hub', 6, 'https://github.com/darold/pgbadger/releases', 'badger', 0, 'badger.png', 'Performance Reporting', 'https://pgbadger.darold.net');
   INSERT INTO releases VALUES ('badger', 8, 'badger','pgBadger','', 'soon', 1);
    INSERT INTO versions VALUES ('badger', '11.1-1', '', 1, '20190916', '');

  INSERT INTO projects VALUES ('bouncer', 2, 0, 'hub', 3, 'https://pgbackrest.org/release.html', 'bouncer',  0, 'bouncer.png', 'Lightweight Connection Pooler', 'https://pgbackrest.org');
   INSERT INTO releases VALUES ('bouncer', 5, 'bouncer',  'pgBouncer', '', 'included', 1);
    INSERT INTO versions VALUES ('bouncer', '1.12.0-1', 'arm, amd', 1, '20191017', '');

-- ##
INSERT INTO families VALUES (50, 'Tools & Client Applications', 'Tools', 'needle_thread.png');
 INSERT INTO categories VALUES (7, 50, 'Toolchain', 'Toolchain');

  INSERT INTO projects VALUES ('docker', 7, 0, 'hub', 1, 'https://github.com/docker/docker-ce/releases', 'docker', 0, 'docker.png', 'Container Runtime', 'https://github.com/docker/docker-ce/#docker-ce');
   INSERT INTO releases VALUES ('docker', 1, 'docker', 'Docker', '', 'soon', 1);
    INSERT INTO versions VALUES ('docker', '19.03.5', 'arm', 1, '20191113', '');

  INSERT INTO projects VALUES ('minikube', 7, 0, 'hub', 2, 'https://github.com/kubernetes/minikube/releases', 'minikube', 0, 'minikube.png', 'Kubernetes (MiniKube)', 'https://minikube.sigs.k8s.io/');
   INSERT INTO releases VALUES ('minikube', 2, 'minikube', 'Local Kubernetes', '', 'bring-own', 1);
    INSERT INTO versions VALUES ('minikube', '1.6.2', 'arm', 1, '20191220', '');

  INSERT INTO projects VALUES ('helm', 7, 0, 'hub', 3, 'https://github.com/helm/helm/releases', 'helm', 0, 'helm.jpg', 'K8s Package Manager', 'https://helm.sh');
   INSERT INTO releases VALUES ('helm', 3, 'helm', 'Helm', '', 'bring-own', 1);
    INSERT INTO versions VALUES ('helm', '3.0.3', 'arm', 1, '20200129', '');

  INSERT INTO projects VALUES ('patroni', 7, 0, 'hub', 4, 'https://github.com/zalando/patroni/releases', 'patroni', 0, 'patroni.png', 'HA Template', 'https://github.com/zalando/patroni');
   INSERT INTO releases VALUES ('patroni', 4, 'patroni', 'Patroni', '', 'bring-own', 1);
    INSERT INTO versions VALUES ('patroni', '1.6.4', '', 1, '20200127', '');

  INSERT INTO projects VALUES ('llvm', 7, 0, 'hub', 3, 'https://github.com/llvm/llvm/releases', 'llvm', 0, 'llvm.png', 'High Level Assembly Language', 'https://llvm.sh');
   INSERT INTO releases VALUES ('llvm', 5, 'llvm', 'LLVM', '', 'bring-own', 1);
    INSERT INTO versions VALUES ('llvm', '3.0.3', 'arm', 1, '20200129', '');

  INSERT INTO projects VALUES ('flex_bison', 7, 0, 'hub', 4, 'https://github.com/zalando/patroni/releases', 'flex_bison', 0, 'flex_bison.png', 'High Availability Template', 'https://github.com/zalando/patroni');
   INSERT INTO releases VALUES ('flex_bison', 6, 'flex_bison', 'Flex & Bison', '', 'bring-own', 1);
    INSERT INTO versions VALUES ('flex_bison', '1.6.4', '', 1, '20200127', '');

-- ##
INSERT INTO categories VALUES (8, 50,  'Client Applications',   'Applications');
 INSERT INTO projects VALUES ('omnidb', 8, 8000, 'docker', 2, 'https://github.com/omnidb/omnidb/releases', 'omnidb', 0, 'omnidb.png', 'RDBMS Web Admin', 'https://github.com/omnidb/omnidb/#omnidb');
  INSERT INTO releases VALUES ('omnidb', 11, 'omnidb', 'OmniDB', '', 'bring-own', 1);
   INSERT INTO versions VALUES ('omnidb', '2.17-1', 'docker', 1, '20191205', '');

 INSERT INTO projects VALUES ('pgadmin4', 8, 1234, 'docker', 1, 'https://pgadmin.org', 'pgadmin4', 0, 'pgadmin4.png', 'PG Web Admin', 'https://pgadmin.org');
  INSERT INTO releases VALUES ('pgadmin4', 1, 'pgadmin4', 'pgAdmin 4', '', 'bring-own', 1);
   INSERT INTO versions VALUES ('pgadmin4', '4.17', 'docker', 1, '20200109', '');

  INSERT INTO projects VALUES ('jdbc', 8, 0, 'hub', 1, 'https://jdbc.postgresql.org', 'jdbc', 0, 'java.png', 'JDBC Driver', 'https://jdbc.postgresql.org');
   INSERT INTO releases VALUES ('jdbc', 7, 'jdbc', 'JDBC', '', 'bring-own', 1);
    INSERT INTO versions VALUES ('jdbc', '42.2.9', '', 1, '20191206', '');

  INSERT INTO projects VALUES ('npgsql', 8, 0, 'hub', 2, 'https://github.com/', 'npgsql', 0, 'npgsql.png', '.NET Provider', 'https://www.npgsql.org');
   INSERT INTO releases VALUES ('npgsql', 10, 'npgsql', '.net PG', '', 'bring-own', 1);
    INSERT INTO versions VALUES ('npgsql', '3.1.0', '', 1, '20191201', '');

  INSERT INTO projects VALUES ('psycopg', 8, 0, 'hub', 3, 'http://initd.org/psycopg', 'psycopg', 0, 'psycopg.png', 'Python Adapter', 'http://initd.org/psycopg');
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
    INSERT INTO versions VALUES ('pgrest', '0.0.7-1', 'arm', 1, '20130813', '');

  INSERT INTO projects VALUES ('ddlx',       8, 0, 'hub', 4, 'https://github.com/lacanoid/pgddl/releases', 'ddlx',  1, 'ddlx.png', 'DDL Extractor', 'https://github.com/lacanoid/pgddl#ddl-extractor-functions--for-postgresql');
   INSERT INTO releases VALUES ('ddlx-pg11', 14, 'ddlx', 'DDLeXtact', '', 'prod', 0);
   INSERT INTO releases VALUES ('ddlx-pg12', 14, 'ddlx', 'DDLeXtact', '', 'prod', 0);
    INSERT INTO versions VALUES ('ddlx-pg11', '0.15-1', 'arm, amd', 1, '20191024', 'pg11');
    INSERT INTO versions VALUES ('ddlx-pg12', '0.15-1', 'arm, amd', 1, '20191024', 'pg12');

