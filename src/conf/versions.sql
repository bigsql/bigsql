DROP VIEW IF EXISTS v_versions;

DROP TABLE IF EXISTS versions;
DROP TABLE IF EXISTS releases;
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS stages;

CREATE TABLE stages (
  stage       TEXT    NOT NULL PRIMARY KEY
);
INSERT INTO stages VALUES ('prod');
INSERT INTO stages VALUES ('test');
INSERT INTO stages VALUES ('deprecated');


CREATE TABLE categories (
  category    INTEGER NOT NULL PRIMARY KEY,
  description TEXT    NOT NULL
);
INSERT INTO categories VALUES (0, 'Hidden');
INSERT INTO categories VALUES (1, 'PostgreSQL');
INSERT INTO categories VALUES (2, 'Other Databases');
INSERT INTO categories VALUES (3, 'Interoperability');
INSERT INTO categories VALUES (4, 'Procedural Languages');
INSERT INTO categories VALUES (5, 'Availability');
INSERT INTO categories VALUES (6, 'Other Extensions');
INSERT INTO categories VALUES (7, 'Kubernetes');
INSERT INTO categories VALUES (8, 'Connectors');
INSERT INTO categories VALUES (9, 'Security');
INSERT INTO categories VALUES (10, 'Admin & Tuning');


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

INSERT INTO projects VALUES ('hub',0,0,'hub',0,'https://github.com/','',0,'','','');

INSERT INTO projects VALUES ('pg', 1, 5432, 'hub', 1, 'https://postgresql.org/download', 
 'postgres', 0, 'postgres.png', 
 'Advanced RDBMS', 'https://postgresql.org');

INSERT INTO projects VALUES ('plprofiler', 4, 0, 'hub', 0, 'https://github.com/bigsql/plprofiler/releases',
 'plprofiler', 1, 'plprofiler.png',
 'Stored Procedure Profiler', 'https://github.com/bigsql/plprofiler#plprofiler');

INSERT INTO projects VALUES ('cassandra_fdw', 3, 0, 'hub', 0, 'https://github.com/bigsql/cassandra_fdw/releases', 
 'cassand', 1, 'cstarfdw.png', 
 'Cassandra Foreign Data Wrapper', 'https://github.com/bigsql/cassandra_fdw#cassandra_fdw');

INSERT INTO projects VALUES ('cassandra', 2, 0, 'hub', 0, 'https://cassandra.apache.org', 
 'cassandra', 0, 'cassandra.png',
 'Multi-Region Multi-Master Big Data', 'https://cassandra.apache.org');

INSERT INTO projects VALUES ('presto_fdw', 3, 0, 'hub', 0, 'https://github.com/bigsql/presto_fdw/releases',
 'presto_fdw', 1, 'prestofdw.png',
 'Access Presto (Athena) data sources from within PG', 'https://github.com/bigsql/presto_fdw#presto_fdw');

INSERT INTO projects VALUES ('presto', 3, 0, 'hub', 0, 'https://github.com/prestodb/presto/releases',
 'presto', 1, 'presto.png',
 'Distributed SQL Query Engine for Big Data', 'https://prestodb.io');

INSERT INTO projects VALUES ('pglogical2', 5, 0, 'hub', 0, 'https://github.com/bigsql/pglogical2/releases',
 'pglogical2', 1, 'pglogical.png',
 'Logical Multi-Master Replication', 'https://github.com/bigsql/pglogical#pglogical2');

INSERT INTO projects VALUES ('mysql', 2, 0, 'hub', 0, 'https://dev.mysql.com/downloads/mysql',
 'mysql', 0, 'mysql.png',
 'MySQL Community Server', 'https://dev.mysql.com');

INSERT INTO projects VALUES ('mysql_fdw', 3, 0, 'hub', 0, 'https://github.com/EnterpriseDB/mysql_fdw/releases',
 'mysql_fdw', 1, 'mysqlfdw.png',
 'Access MySQL databases from within PG', 'https://github.com/EnterpriseDb/mysql_fdw');

INSERT INTO projects VALUES ('oracle_xe', 2, 0, 'hub', 0, 'https://oracle.com',
 'oracle_xe', 0, 'oracle_xe.png',
 'Oracle Database Express Edition', 'https://oracle.com');

INSERT INTO projects VALUES ('oracle_fdw', 3, 0, 'hub', 0, 'https://github.com/laurenz/oracle_fdw/releases',
 'oracle_fdw', 1, 'oraclefdw.png',
 'Access Oracle Databases Extension', 'https://github.com/laurenz/oracle_fdw');

INSERT INTO projects VALUES ('pglogical', 5, 0, 'hub', 0, 'https://github.com/2ndQuadrant/pglogical/releases',
 'pglogical', 1, 'pglogical.png',
 'Logical Replication Extension', 'https://github.com/2ndQuadrant/pglogical#pglogical-2');

INSERT INTO projects VALUES ('timescaledb', 6, 0, 'hub', 0, 'https://github.com/timescale/timescaledb/releases',
 'timescaledb', 1, 'timescaledb.png',
 'Time Series Extension', 'https://github.com/timescale/timescaledb/#timescaledb');

INSERT INTO projects VALUES ('ddlx', 10, 0, 'hub', 0, 'https://github.com/lacanoid/pgddl/releases',
 'ddlx',  1, 'ddlx.png',
 'DDL Extractor', 'https://github.com/lacanoid/pgddl#ddl-extractor-functions--for-postgresql');

INSERT INTO projects VALUES ('http', 3, 0, 'hub', 0, 'https://github.com/pramsey/pgsql-http/releases',
 'http',  1, 'curl.png',
 'HTTP Client Extension', 'https://github.com/pramsey/pgsql-http');

INSERT INTO projects VALUES ('anon', 9, 0, 'ddlx', 0, 'https://gitlab.com/dalibo/postgresql_anonymizer/releases',
 'anon', 1, 'anon.png', 
 'PostgreSQL Anonymizer Extension', 'https://gitlab.com/dalibo/postgresql_anonymizer/blob/master/README.md');

INSERT INTO projects VALUES ('pgtsql', 4, 0, 'hub', 0, 'https://github.com/bigsql/pgtsql/releases',
 'pgtsql', 1, 'tsql.png',
 'SQL Server & Sybase Stored Proc Extension', 'https://github.com/bigsql/pgtsql#pgtsql');

INSERT INTO projects VALUES ('pgosql', 4, 0, 'hub', 0, 'https://github.com/bigsql/pgosql/releases',
 'pgosql', 1, 'pgosql.png',
 'Oracle Style Stored Proc Extension', 'https://github.com/bigsq/pgosql#pgosql');

INSERT INTO projects VALUES ('orafce', 4, 0, 'hub', 0, 'https://github.com/orafce/orafce/releases',
 'orafce', 1, 'orafce.png',
 'Oracle Compatible Built-in Functions and Packages', 'https://github.com/orafce/orafce#orafce---oracles-compatibility-functions-and-packages');

INSERT INTO projects VALUES ('hypopg', 10, 0, 'hub', 0, 'https://github.com/HypoPG/hypopg/releases',
 'hypopg', 1, 'hypopg.png',
 'Hypothetical Indexes', 'https://hypopg.readthedocs.io/en/latest/');

INSERT INTO projects VALUES ('docker', 7, 0, 'hub', 0, 'https://github.com/docker/docker-ce/releases',
 'docker', 0, 'docker.png',
 'Container Runtime', 'https://github.com/docker/docker-ce/#docker-ce');

INSERT INTO projects VALUES ('omnidb', 10, 8000, 'docker', 0, 'https://github.com/omnidb/omnidb/releases',
 'omnidb', 0, 'omnidb.png',
 'Admin for PG, Oracle, SQL Server, & MySQL', 'https://github.com/omnidb/omnidb/#omnidb');

INSERT INTO projects VALUES ('patroni', 7, 0, 'hub', 0, 'https://github.com/zalando/patroni/releases',
 'patroni', 0, 'patroni.png',
 'High Availability', 'https://github.com/zalando/patroni');

INSERT INTO projects VALUES ('minikube', 7, 0, 'hub', 0, 'https://github.com/kubernetes/minikube/releases',
 'minikube', 0, 'minikube.png',
 'Local Kubernetes for application development', 'https://minikube.sigs.k8s.io/');

INSERT INTO projects VALUES ('pgrest', 3, 0, 'hub', 0, 'https://github.com/pgrest/pgrest/releases',
 'pgrest', 0, 'pgrest.png',
 'A RESTful Data API leveraging Plv8', 'https://github.com/pgrest/pgrest');

INSERT INTO projects VALUES ('backrest', 5, 0, 'hub', 0, 'https://pgbackrest.org/release.html',
 'backrest', 0, 'backrest.png',
 'Reliable Backup & Restore', 'https://pgbackrest.org');

INSERT INTO projects VALUES ('bouncer', 5, 0, 'hub', 0, 'https://github.com/pgbouncer/pgbouncer/releases',
 'bouncer', 0, 'bouncer.png',
 'Lightweight Connection Pooler', 'http://pgbouncer.org');

INSERT INTO projects VALUES ('psycopg', 8, 0, 'hub', 0, 'http://initd.org/psycopg',
 'psycopg', 0, 'psycopg.png',
 'Python Adapter', 'http://initd.org/psycopg');

INSERT INTO projects VALUES ('badger',10, 0, 'hub', 0, 'https://github.com/darold/pgbadger/releases',
 'badger', 0, 'badger.png',
 'Fast Log Analysis Reports', 'https://pgbadger.darold.net');

INSERT INTO projects VALUES ('npgsql', 8, 0, 'hub', 0, 'https://github.com/',
 'npgsql', 0, 'npgsql.png',
 'ADO.NET Data Provider', 'https://www.npgsql.org');

INSERT INTO projects VALUES ('ruby', 8, 0, 'hub', 0, 'https://rubygems.org/gems/pg',
 'ruby', 0, 'ruby.png',
 'Ruby Interface to PostgreSQL', 'https://github.com');

INSERT INTO projects VALUES ('jdbc', 8, 0, 'hub', 0, 'https://jdbc.postgresql.org',
 'jdbc', 0, 'jdbc.png',
 'Type 4 JDBC Driver', 'https://jdbc.postgresql.org');

INSERT INTO projects VALUES ('odbc', 8, 0, 'hub', 0, 'https://www.postgresql.org/ftp/odbc/versions/msi/',
 'odbc', 0, 'odbc.png',
 'The official Postgres ODBC Driver', 'https://odbc.postgresql.org');

INSERT INTO projects VALUES ('helm', 8, 0, 'hub', 0, 'https://github.com/helm/helm/releases',
 'helm', 0, 'helm.png',
 'Kubernetes Package Manager', 'https://helm.sh');


CREATE TABLE releases (
  component  TEXT     NOT NULL PRIMARY KEY,
  sort_order SMALLINT NOT NULL,
  project    TEXT     NOT NULL,
  disp_name  TEXT     NOT NULL,
  doc_url    TEXT     NOT NULL,
  stage      TEXT     NOT NULL,
  FOREIGN KEY (project) REFERENCES projects(project),
  FOREIGN KEY (stage)   REFERENCES stages(stage)
);
INSERT INTO releases VALUES ('hub',                1, 'hub',           'Hidden',       '', 'prod');

INSERT INTO releases VALUES ('pg11',              15, 'pg',            'Postgres 11',  '/docs/11/',  'prod');
INSERT INTO releases VALUES ('pg12',              16, 'pg',            'Postgres 12',  '/docs/12/',  'prod');

INSERT INTO releases VALUES ('hypopg-pg11',        1, 'hypopg',        'HypoPG',       '', 'prod');

INSERT INTO releases VALUES ('pgtsql-pg11',        1, 'pgtsql',        'pgTSQL',       '', 'prod');

INSERT INTO releases VALUES ('pgosql-pg11',        1, 'pgosql',        'pgOSQL',       '', 'test');

INSERT INTO releases VALUES ('orafce-pg11',        1, 'orafce',        'OraFCE',       '', 'prod');

INSERT INTO releases VALUES ('pglogical2-pg11',    1, 'pglogical2',    'pgLogical2',   '', 'test');

INSERT INTO releases VALUES ('pglogical-pg11',     1, 'pglogical',     'pgLogical',    '', 'prod');

INSERT INTO releases VALUES ('oracle_fdw-pg11',     1, 'oracle_fdw',     'Oracle FDW',     '', 'prod');
INSERT INTO releases VALUES ('oracle_xe',           1, 'oracle_xe',      'Oracle Express', '', 'test');

INSERT INTO releases VALUES ('mysql_fdw-pg11',      1, 'mysql_fdw',      'MySQL FDW',    '', 'prod');
INSERT INTO releases VALUES ('mysql',               1, 'mysql',          'MySQL Server', '', 'test');

INSERT INTO releases VALUES ('plprofiler-pg11',    1, 'plprofiler',    'plProfiler',   'https://github.com/bigsql/plprofiler', 'prod');

INSERT INTO releases VALUES ('ddlx-pg11',          1, 'ddlx',          'DDLeXtractor',  '', 'prod');

INSERT INTO releases VALUES ('http-pg11',          1, 'http',          'HTTP Client',   '', 'prod');

INSERT INTO releases VALUES ('anon-pg11',          1, 'anon',          'Anonymizer',    '', 'prod');

INSERT INTO releases VALUES ('timescaledb-pg11',   1, 'timescaledb',   'TimescaleDB',   '', 'prod');

INSERT INTO releases VALUES ('cassandra',          1, 'cassandra',     'Cassandra',     '', 'test');
INSERT INTO releases VALUES ('cassandra_fdw-pg11', 1, 'cassandra_fdw', 'Cassandra FDW', '', 'prod');

INSERT INTO releases VALUES ('presto',             1, 'presto',        'Presto',        '', 'prod');
INSERT INTO releases VALUES ('presto_fdw-pg11',    1, 'presto_fdw',    'Presto FDW',    '', 'prod');

INSERT INTO releases VALUES ('minikube',           1, 'minikube',      'MiniKube',     '', 'prod');
INSERT INTO releases VALUES ('pgrest',             1, 'pgrest',        'pgREST',       '', 'prod');
INSERT INTO releases VALUES ('bouncer',            1, 'bouncer',       'pgBouncer',    '', 'prod');
INSERT INTO releases VALUES ('psycopg',            1, 'psycopg',       'psycopg',      '', 'prod');
INSERT INTO releases VALUES ('ruby',               1, 'ruby',          'ruby',         '', 'prod');
INSERT INTO releases VALUES ('badger',             1, 'badger',        'Badger',       '', 'prod');
INSERT INTO releases VALUES ('npgsql',             1, 'npgsql',        '.net PGSQL',   '', 'prod');
INSERT INTO releases VALUES ('jdbc',               1, 'jdbc',          'JDBC',         '', 'prod');
INSERT INTO releases VALUES ('odbc',               1, 'odbc',          'ODBC',         '', 'prod');
INSERT INTO releases VALUES ('backrest',           1, 'backrest',      'pgBackrest',   '', 'prod');
INSERT INTO releases VALUES ('helm',               1, 'helm',          'Helm',         '', 'prod');
INSERT INTO releases VALUES ('patroni',            1, 'patroni',       'Patroni',      '', 'prod');
INSERT INTO releases VALUES ('docker',             1, 'docker',        'Docker CE',    '', 'prod');
INSERT INTO releases VALUES ('omnidb',             1, 'omnidb',        'OmniDB',       '', 'prod');


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

INSERT INTO versions VALUES ('hub', '5.1.2', '', 1, '20200101', '');
INSERT INTO versions VALUES ('hub', '5.1.1', '', 0, '20191224', '');
INSERT INTO versions VALUES ('hub', '5.1.0', '', 0, '20191213', '');

INSERT INTO versions VALUES ('pg11',               '11.6-6',   'linux64, arm64',               1, '20191114', '');
INSERT INTO versions VALUES ('pg11',               '11.6-5',   'linux64, arm64',               0, '20191114', '');
INSERT INTO versions VALUES ('pg11',               '11.6-4',   'linux64, arm64',               0, '20191114', '');

INSERT INTO versions VALUES ('pg12',               '12.1-6',   'linux64, arm64',               1, '20191114', '');
INSERT INTO versions VALUES ('pg12',               '12.1-5',   'linux64, arm64',               0, '20191114', '');
INSERT INTO versions VALUES ('pg12',               '12.1-4',   'linux64, arm64',               0, '20191114', '');

INSERT INTO versions VALUES ('hypopg-pg11',        '1.1.3-1',  'linux64, arm64',               1, '20191123', 'pg11');

INSERT INTO versions VALUES ('orafce-pg11',        '3.8.0-1',  'linux64, arm64',               1, '20190522', 'pg11');

INSERT INTO versions VALUES ('pgosql-pg11',        '2.0-1',    'linux64',                      0, '20191211', 'pg11');

INSERT INTO versions VALUES ('pgtsql-pg11',        '3.0-1',    'linux64, arm64',               1, '20191119', 'pg11');

INSERT INTO versions VALUES ('pglogical2-pg11',    '2.3.1beta1-1', 'linux64, arm64',           0, '20191212', 'pg11');

INSERT INTO versions VALUES ('pglogical-pg11',     '2.2.2-1',  'linux64, arm64',               1, '20190725', 'pg11');

INSERT INTO versions VALUES ('oracle_xe',          '11.2.0',   'linux64',                      1, '20191010', '');
INSERT INTO versions VALUES ('oracle_fdw-pg11',    '2.2.0-1',  'linux64',                      1, '20191010', 'pg11');

INSERT INTO versions VALUES ('mysql',              '8.0.18',   'linux64',                      1, '20191014', '');
INSERT INTO versions VALUES ('mysql_fdw-pg11',     '2.5.3-1',  'linux64',                      1, '20190927', 'pg11');

INSERT INTO versions VALUES ('plprofiler-pg11',    '4.1-1',    'linux64, arm64',               1, '20190823', 'pg11');

INSERT INTO versions VALUES ('ddlx-pg11',          '0.15-1',   'linux64, arm64',               1, '20191024', 'pg11');

INSERT INTO versions VALUES ('http-pg11',          '1.3.1-1',  'linux64, arm64',               1, '20191225', 'pg11');

INSERT INTO versions VALUES ('anon-pg11',          '0.5.0-1',  'linux64, arm64',               1, '20191109', 'pg11');

INSERT INTO versions VALUES ('timescaledb-pg11',   '1.5.1-1',  'linux64, arm64',               1, '20191112', 'pg11');

INSERT INTO versions VALUES ('cassandra',          '3.11.5',   '',                             1, '20191029', '');
INSERT INTO versions VALUES ('cassandra_fdw-pg11', '3.1.5-1',  'linux64',                      1, '20191230', 'pg11');

INSERT INTO versions VALUES ('presto',             '0.229',    '',                             1, '20191115', '');
INSERT INTO versions VALUES ('presto_fdw-pg11',    '3.2-1',    'linux64',                      1, '20191230', 'pg11');

INSERT INTO versions VALUES ('badger',             '11.1-1',   '',                             1, '20190916', '');
INSERT INTO versions VALUES ('pgrest',             '0.0.7-1',  'linux64, arm64',               1, '20130813', '');
INSERT INTO versions VALUES ('bouncer',            '1.12.0-1', 'linux64, arm64',               1, '20191017', '');

INSERT INTO versions VALUES ('psycopg',            '2.8.4',    '',                             0, '20191020', '');
INSERT INTO versions VALUES ('ruby',               '1.2.0',    '',                             0, '20191224', '');
INSERT INTO versions VALUES ('npgsql',             '3.1.0',    '',                             0, '20191201', '');
INSERT INTO versions VALUES ('jdbc',               '42.2.9',   '',                             0, '20191206', '');
INSERT INTO versions VALUES ('odbc',               '12.00-1',  'linux64, arm64',               1, '20191011', '');

INSERT INTO versions VALUES ('backrest',           '2.20-1',   'linux64, arm64',               1, '20191218', '');

INSERT INTO versions VALUES ('helm',               '3.0.2',    'linux64',                      1, '20191218', '');

INSERT INTO versions VALUES ('minikube',           '1.6.2',    'linux64',                      1, '20191220', '');

INSERT INTO versions VALUES ('docker',             '19.03.5',  'linux64',                      1, '20191113', '');

INSERT INTO versions VALUES ('omnidb',             '2.17-1',   'docker',                       1, '20191205', '');

INSERT INTO versions VALUES ('patroni',            '1.6.3',    '',                             1, '20191205', '');


CREATE VIEW v_versions AS
  SELECT p.category as cat, c.description as cat_desc, p.image_file,
         r.component, r.project, r.stage, r.disp_name as release_name,
         v.version, p.sources_url, p.project_url, v.platform, 
         v.is_current, v.release_date, p.description as proj_desc
    FROM categories c, projects p, releases r, versions v
   WHERE c.category = p.category
     AND p.project = r.project
     AND r.component = v.component;
