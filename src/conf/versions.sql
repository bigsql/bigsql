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
INSERT INTO categories VALUES (2, 'Extensions');
INSERT INTO categories VALUES (3, 'Servers');
INSERT INTO categories VALUES (4, 'Applications');


CREATE TABLE projects (
  project   	 TEXT    NOT NULL PRIMARY KEY,
  category  	 INTEGER NOT NULL,
  port      	 INTEGER NOT NULL,
  depends   	 TEXT    NOT NULL,
  start_order    INTEGER NOT NULL,
  sources_url    TEXT    NOT NULL,
  short_name     TEXT    NOT NULL,
  short_desc     TEXT    NOT NULL,
  image_file     TEXT    NOT NULL,
  description    TEXT    NOT NULL,
  project_url    TEXT    NOT NULL,
  FOREIGN KEY (category) REFERENCES categories(category)
);

INSERT INTO projects VALUES ('hub', 0, 0, 'hub', 0, 'https://github.com/',
 '',  '', '',
 '', '');

INSERT INTO projects VALUES ('pg', 1, 5432, 'hub', 1, 'https://postgresql.org/download', 
 'postgres', 'PostgreSQL', 'postgres.png', 
 'Advanced RDBMS', 'https://postgresql.org');

INSERT INTO projects VALUES ('plprofiler', 2, 0, 'hub', 0, 'https://github.com/bigsql/plprofiler/releases',
 'plprofiler', 'plProfiler', 'plprofiler.png',
 'Stored Procedure Profiler', 'https://github.com/bigsql/plprofiler#plprofiler');

INSERT INTO projects VALUES ('cassandra_fdw', 2, 0, 'hub', 0, 'https://github.com/bigsql/cassandra_fdw/releases', 'cassandra_fdw', 'CassandraFDW', 'cassandra.png',
 'Cassandra Foreign Data Wrapper', 'https://github.com/bigsql/cassandra_fdw#cassandra_fdw');

INSERT INTO projects VALUES ('athena_fdw', 2, 0, 'hub', 0, 'https://github.com/bigsql/athena_fdw/releases',
 'athena_fdw', 'AthenaFDW', 'athena.png',
 'Athena (Presto) Foreign Data Wrapper', 'https://github.com/bigsql/athena_fdw#athena_fdw');

INSERT INTO projects VALUES ('pglogical2', 2, 0, 'hub', 0, 'https://github.com/bigsql/pglogical2/releases',
 'pglogical2', 'pgLogical2', 'pglogical.png',
 'Logical Multi-Master Replication', 'https://github.com/bigsql/pglogical#pglogical2');

INSERT INTO projects VALUES ('pglogical', 2, 0, 'hub', 0, 'https://github.com/2ndQuadrant/pglogical/releases',
 'pglogical', 'pgLogical', 'pglogical.png',
 'Logical Replication', 'https://github.com/2ndQuadrant/pglogical#pglogical-2');

INSERT INTO projects VALUES ('timescaledb', 2, 0, 'hub', 0, 'https://github.com/timescale/timescaledb/releases',
 'timescaledb', 'TimescaleDB', 'timescaledb.png',
 'Time Series Extension', 'https://github.com/timescale/timescaledb/#timescaledb');

INSERT INTO projects VALUES ('ddlx', 2, 0, 'hub', 0, 'https://github.com/lacanoid/pgddl/releases',
 'ddlx',  'DDLeXtractor', 'ddlx.png',
 'DDL Extractor', 'https://github.com/lacanoid/pgddl#ddl-extractor-functions--for-postgresql');

INSERT INTO projects VALUES ('http', 2, 0, 'hub', 0, 'https://github.com/pramsey/pgsql-http/releases',
 'http',  'HTTP Client', 'curl.png',
 'HTTP Client', 'https://github.com/pramsey/pgsql-http');

INSERT INTO projects VALUES ('anon', 2, 0, 'ddlx', 0, 'https://gitlab.com/dalibo/postgresql_anonymizer/releases',
 'anon', 'Anonymizer', 'anon.png', 
 'PostgreSQL Anonymizer', 'https://gitlab.com/dalibo/postgresql_anonymizer/blob/master/README.md');

INSERT INTO projects VALUES ('pgtsql', 2, 0, 'hub', 0, 'https://github.com/bigsql/pgtsql/releases',
 'pgtsql', 'pgTSQL', 'tsql.png',
 'SQL Server & Sybase Compatible Stored Procs', 'https://github.com/bigsq/pgtsql#pgtsqll');

INSERT INTO projects VALUES ('pgosql', 2, 0, 'hub', 0, 'https://github.com/bigsql/pgosql/releases',
 'pgosql', 'pgOSQL', 'pgosql.png',
 'Oracle Compatible Stored Procs', 'https://github.com/bigsq/pgosql#pgosql');

INSERT INTO projects VALUES ('orafce', 2, 0, 'hub', 0, 'https://github.com/orafce/orafce/releases',
 'orafce', 'OraFCE', 'orafce.png',
 'Oracle Compatible Built-in Functions and Packages', 'https://github.com/orafce/orafce#orafce---oracles-compatibility-functions-and-packages');

INSERT INTO projects VALUES ('hypopg', 2, 0, 'hub', 0, 'https://github.com/HypoPG/hypopg/releases',
 'hypopg', 'HypoPG', 'hypopg.png',
 'Hypothetical Indexes', 'https://hypopg.readthedocs.io/en/latest/');

INSERT INTO projects VALUES ('docker', 3, 0, 'hub', 0, 'https://github.com/docker/docker-ce/releases',
 'docker', 'Docker', 'docker.png',
 'Container Runtime', 'https://github.com/docker/docker-ce/#docker-ce');

INSERT INTO projects VALUES ('omnidb', 3, 8000, 'docker', 0, 'https://github.com/omnidb/omnidb/releases',
 'omnidb', 'OmniDB', 'omnidb.png',
 'DB Admin & Monitoring for PG, Oracle, SQL Server, Sybase, and MySQL', 'https://github.com/omnidb/omnidb/#omnidb');

INSERT INTO projects VALUES ('patroni', 3, 0, 'hub', 0, 'https://github.com/zalando/patroni/releases',
 'patroni', 'Patroni', 'patroni.png',
 'BigSQL High Availability for Kubernetes', 'https://github.com/zalando/patroni');

INSERT INTO projects VALUES ('minikube', 3, 0, 'hub', 0, 'https://github.com/kubernetes/minikube/releases',
 'minikube', 'MiniKube', 'minikube.png',
 'Run Kubernetes locally', 'https://minikube.sigs.k8s.io/');


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

INSERT INTO releases VALUES ('pgosql-pg11',        1, 'pgosql',        'pgOSQL',       '', 'prod');

INSERT INTO releases VALUES ('orafce-pg11',        1, 'orafce',        'OraFCE',       '', 'prod');

INSERT INTO releases VALUES ('pglogical2-pg11',    1, 'pglogical2',    'pgLogical2',   '', 'test');
INSERT INTO releases VALUES ('pglogical-pg11',     1, 'pglogical',     'pgLogical',    '', 'prod');

INSERT INTO releases VALUES ('plprofiler-pg11',    1, 'plprofiler',    'plProfiler',   'https://github.com/bigsql/plprofiler', 'prod');

INSERT INTO releases VALUES ('ddlx-pg11',          1, 'ddlx',          'DDLeXtractor', '', 'prod');

INSERT INTO releases VALUES ('http-pg11',          1, 'http',          'HTTP via cURL', '', 'prod');

INSERT INTO releases VALUES ('anon-pg11',          1, 'anon',          'Anonymizer',   '', 'prod');

INSERT INTO releases VALUES ('timescaledb-pg11',   1, 'timescaledb',   'TimescaleDB',  '', 'prod');

INSERT INTO releases VALUES ('cassandra_fdw-pg11', 1, 'cassandra_fdw', 'CassandraFDW', '', 'test');

INSERT INTO releases VALUES ('athena_fdw-pg11',    1, 'athena_fdw',    'AthenaFDW',    '', 'test');

INSERT INTO releases VALUES ('minikube',           1, 'minikube',      'MiniKube',     '', 'test');
INSERT INTO releases VALUES ('patroni',            1, 'patroni',       'Patroni',      '', 'test');
INSERT INTO releases VALUES ('docker',             1, 'docker',        'Docker CE',    '', 'test');
INSERT INTO releases VALUES ('omnidb',             1, 'omnidb',        'OmniDB',       '', 'test');


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

INSERT INTO versions VALUES ('hub', '5.1.1', '', 1, '20200101', '');
INSERT INTO versions VALUES ('hub', '5.1.0', '', 0, '20191213', '');

INSERT INTO versions VALUES ('pg11',               '11.6-5',   'linux64',                      1, '20191218', '');
INSERT INTO versions VALUES ('pg11',               '11.6-4',   'linux64, arm64, osx64',        0, '20191114', '');

INSERT INTO versions VALUES ('pg12',               '12.1-5',   'linux64',                      1, '20191218', '');
INSERT INTO versions VALUES ('pg12',               '12.1-4',   'linux64, arm64, osx64',        0, '20191114', '');

INSERT INTO versions VALUES ('hypopg-pg11',        '1.1.3-1',  'linux64',                      1, '20191123', 'pg11');

INSERT INTO versions VALUES ('orafce-pg11',        '3.8-1',    'linux64,',                     1, '20190522', 'pg11');

INSERT INTO versions VALUES ('pgosql-pg11',        '2.0-1',    'linux64,',                     1, '20191211', 'pg11');

INSERT INTO versions VALUES ('pgtsql-pg11',        '3.0-1',    'linux64,',                     1, '20191119', 'pg11');

INSERT INTO versions VALUES ('pglogical2-pg11',    '2.3.1beta1-1', 'linux64',                  1, '20191212', 'pg11');
INSERT INTO versions VALUES ('pglogical-pg11',     '2.2.2-1',  'linux64',                      1, '20190725', 'pg11');

INSERT INTO versions VALUES ('plprofiler-pg11',    '4.1-1',    'linux64',                      1, '20190823', 'pg11');

INSERT INTO versions VALUES ('ddlx-pg11',          '0.15-1',   'linux64',                      1, '20191024', 'pg11');

INSERT INTO versions VALUES ('http-pg11',          '1.3.1-1',  'linux64',                      1, '20191225', 'pg11');

INSERT INTO versions VALUES ('anon-pg11',          '0.5.0-1',  'linux64',                      1, '20191109', 'pg11');

INSERT INTO versions VALUES ('timescaledb-pg11',   '1.5.1-1',  'linux64',                      1, '20191112', 'pg11');

INSERT INTO versions VALUES ('cassandra_fdw-pg11', '3.1.4-1',  'linux64',                      1, '20190802', 'pg11');

INSERT INTO versions VALUES ('athena_fdw-pg11',    '3.1-2',    'linux64',                      1, '20190707', 'pg11');

INSERT INTO versions VALUES ('minikube',           '1.6.0',    'linux64',                      1, '20191210', '');

INSERT INTO versions VALUES ('docker',             '19.03',    '',                      1, '20191113', '');

INSERT INTO versions VALUES ('omnidb',             '2.16-1',   '',                      1, '20190613', '');

INSERT INTO versions VALUES ('patroni',            '1.6.3',    '',                      1, '20191205', '');
INSERT INTO versions VALUES ('patroni',            '1.6.1',    '',                      0, '20191115', '');


CREATE VIEW v_versions AS
  SELECT p.category as cat, c.description as cat_desc, p.image_file,
         r.component, r.project, r.stage, r.disp_name as release_name,
         v.version, p.sources_url, p.project_url, v.platform, 
         v.is_current, v.release_date, p.description as proj_desc
    FROM categories c, projects p, releases r, versions v
   WHERE c.category = p.category
     AND p.project = r.project
     AND r.component = v.component;
