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
  FOREIGN KEY (category) REFERENCES categories(category)
);
INSERT INTO projects VALUES ('hub', 0, 0, 'hub', 0, 'https://github.com/', '',  '', '', '');

INSERT INTO projects VALUES ('pg', 1, 5432, 'hub', 1, 'https://git.postgresql.org/', 'postgres', 'PostgreSQL', '', 
  '');

INSERT INTO projects VALUES ('plprofiler', 2, 0, 'hub', 0, 'https://github.com/bigsql/plprofiler', 'pl_profiler', 'plProfiler', '',
  '');

INSERT INTO projects VALUES ('cassandra_fdw', 2, 0, 'hub', 0, 'https://github.com/bigsql/cassandra_fdw', 'cassandra_fdw', 'CassandraFDW', '',
  '');

INSERT INTO projects VALUES ('athena_fdw', 2, 0, 'hub', 0, 'https://github.com/bigsql/athena_fdw', 'athena_fdw', 'AthenaFDW', '',
  '');

INSERT INTO projects VALUES ('pglogical', 2, 0, 'hub', 0, 'https://github.com/2ndQuadrant/pglogical', 'pg_logical', 'pgLogical', '',
  '');

INSERT INTO projects VALUES ('timescaledb', 2, 0, 'hub', 0, 'https://github.com/', 'timescaledb', 'TimescaleDB', '',
  '');

INSERT INTO projects VALUES ('ddlx', 2, 0, 'hub', 0, 'https://github.com/', 'DDLeXtractor', '', '',
  '');

INSERT INTO projects VALUES ('anon', 2, 0, 'ddlx', 0, 'https://github.com/', 'Anonymizer', 'anon.png', '',
  '');

INSERT INTO projects VALUES ('pgtsql', 2, 0, 'hub', 0, 'https://github.com/', '', '', '',
  '');

INSERT INTO projects VALUES ('hypopg', 2, 0, 'hub', 0, 'https://github.com/', '', '', '',
  '');

INSERT INTO projects VALUES ('omnidb', 3, 8000, 'hub', 0, 'https://github.com/', '', '', '',
  '');

INSERT INTO projects VALUES ('patroni', 3, 0, 'hub', 0, 'https://github.com/', '', '', '',
  '');


CREATE TABLE releases (
  component  TEXT    NOT NULL PRIMARY KEY,
  project    TEXT    NOT NULL,
  disp_name  TEXT    NOT NULL,
  short_desc TEXT    NOT NULL,
  sup_plat   TEXT    NOT NULL,
  doc_url    TEXT    NOT NULL,
  stage      TEXT    NOT NULL,
  FOREIGN KEY (project) REFERENCES projects(project),
  FOREIGN KEY (stage)   REFERENCES stages(stage)
);
INSERT INTO releases VALUES ('hub', 'hub', 'Hidden', 'Hidden', '',  '', 'prod');

INSERT INTO releases VALUES ('pg94', 'pg', 'PostgreSQL 9.4', 'PG Server', '', '/docs/9.4/', 'prod');
INSERT INTO releases VALUES ('pg95', 'pg', 'PostgreSQL 9.5', 'PG Server', '', '/docs/9.5/', 'prod');
INSERT INTO releases VALUES ('pg96', 'pg', 'PostgreSQL 9.6', 'PG Server', '', '/docs/9.6/', 'prod');
INSERT INTO releases VALUES ('pg10', 'pg', 'PostgreSQL 10',  'PG Server', '', '/docs/10/',  'prod');
INSERT INTO releases VALUES ('pg11', 'pg', 'PostgreSQL 11',  'PG Server', '', '/docs/11/',  'prod');
INSERT INTO releases VALUES ('pg12', 'pg', 'PostgreSQL 12',  'PG Server', '', '/docs/12/',  'prod');
INSERT INTO releases VALUES ('pg13', 'pg', 'PostgreSQL 13',  'PG Server', '', '/docs/13/',  'test');

INSERT INTO releases VALUES ('hypopg-pg11', 'hypopg', 'hypoPG', 'Hypothetical Indexes', '', '', 'prod');

INSERT INTO releases VALUES ('pgtsql-pg11', 'pgtsql', 'pgTSQL', 'Transact SQL like', '', '', 'prod');

INSERT INTO releases VALUES ('pglogical-pg11', 'pglogical', 'pgLogical', 'Logical Replication', '', '', 'prod');

INSERT INTO releases VALUES ('plprofiler-pg11', 'plprofiler', 'plProfiler', 'PL Performance Profiler', '', 'https://github.com/bigsql/plprofiler', 'prod');

INSERT INTO releases VALUES ('ddlx-pg11', 'ddlx', 'DDL Extractor', '', '', '', 'prod');

INSERT INTO releases VALUES ('anon-pg11', 'anon', 'Anonymizer', '', '', '', 'prod');

INSERT INTO releases VALUES ('timescaledb-pg11', 'timescaledb', 'TimescaleDB', '', '', '', 'prod');

INSERT INTO releases VALUES ('cassandra_fdw-pg11', 'cassandra_fdw', 'CassandraFDW', 'C* Interoperability', '', '', 'test');
INSERT INTO releases VALUES ('athena_fdw-pg11', 'athena_fdw', 'AthenaFDW', 'Hive Queries', '', '', 'test');

INSERT INTO releases VALUES ('patroni', 'patroni',  '', '', '', '', 'prod');
INSERT INTO releases VALUES ('omnidb',  'omnidb',   '', '', '', '', 'test');
INSERT INTO releases VALUES ('salt',    'salt',     '', '', '', '', 'test');


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

INSERT INTO versions VALUES ('hub', '21.01.15-1', '', 1, '20210115', '');

INSERT INTO versions VALUES ('pg94', '9.4.25-1',           'linux64, arm64', 1, '20191114', '');

INSERT INTO versions VALUES ('pg95', '9.5.20-1',           'linux64, arm64', 1, '20191114', '');

INSERT INTO versions VALUES ('pg96', '9.6.16-1',           'linux64, arm64', 1, '20191114', '');

INSERT INTO versions VALUES ('pg10', '10.11-4',            'linux64, arm64', 1, '20191114', '');

INSERT INTO versions VALUES ('pg11', '11.6-4',             'linux64, arm64, osx64', 1, '20191114', '');

INSERT INTO versions VALUES ('pg12', '12.1-4',             'linux64, arm64', 1, '20191114', '');

INSERT INTO versions VALUES ('hypopg-pg11', '1.1.3-1',     'linux64, arm64', 1, '20191114', 'pg11');

INSERT INTO versions VALUES ('pgtsql-pg11', '3.0-1',       'linux64, arm64', 1, '20191114', 'pg11');

INSERT INTO versions VALUES ('pglogical-pg11',  '2.2.2-1', 'linux64, arm64', 1, '20191114', 'pg11');

INSERT INTO versions VALUES ('plprofiler-pg11', '4.1-1',   'linux64, arm64', 1, '20191114', 'pg11');

INSERT INTO versions VALUES ('ddlx-pg11', '0.15-1',        'linux64, arm64', 1, '20191114', 'pg11');

INSERT INTO versions VALUES ('anon-pg11', '0.5.0-1',          'linux64, arm64', 1, '20191114', 'pg11');

INSERT INTO versions VALUES ('timescaledb-pg11', '1.5.1-1',   'linux64, arm64', 1, '20191114', 'pg11');

INSERT INTO versions VALUES ('cassandra_fdw-pg11', '3.1.4-1', 'linux64', 0, '20191114', 'pg11');

INSERT INTO versions VALUES ('athena_fdw-pg11', '3.1-2',      'linux64', 0, '20101114', 'pg11');

INSERT INTO versions VALUES ('salt',    '2019pp', 'linux64', 0, '20190912', '');
INSERT INTO versions VALUES ('omnidb',  '2.16-1', 'linux64', 0, '20191112', '');
INSERT INTO versions VALUES ('patroni', '1.6.1',  '',        0, '20191118', '');

