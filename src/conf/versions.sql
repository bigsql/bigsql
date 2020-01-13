DROP VIEW IF EXISTS v_versions;

DROP TABLE IF EXISTS versions;
DROP TABLE IF EXISTS releases;
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS categories;

CREATE TABLE categories (
  category    INTEGER NOT NULL PRIMARY KEY,
  description TEXT    NOT NULL,
  short_desc  TEXT    NOT NULL
);
INSERT INTO categories VALUES (0,  'Hidden', '');
INSERT INTO categories VALUES (1,  'PostgreSQL Durability',                'PostgreSQL');
INSERT INTO categories VALUES (2,  'Interoperability & Compatibility',     'Interoperability');
INSERT INTO categories VALUES (3,  'Security, Scalability & Availability', 'Abilities');
INSERT INTO categories VALUES (4,  'Applications & Connectors',            'Applications');

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

INSERT INTO projects VALUES ('hub',0, 0,    'hub', 0, 'https://github.com/','',0,'','','');
INSERT INTO projects VALUES ('pg', 1, 5432, 'hub', 1, 'https://postgresql.org/download', 'postgres', 0, 'postgres.png', 'Most Advanced RDBMS', 'https://postgresql.org');

INSERT INTO projects VALUES ('cassandra',  2, 0, 'hub', 0, 'https://cassandra.apache.org', 'cassandra', 0, 'cstar.png', 'Multi-Master Big Data', 'https://cassandra.apache.org');
INSERT INTO projects VALUES ('cassandra_fdw', 2, 0, 'hub', 0, 'https://github.com/bigsql/cassandra_fdw/releases', 'cstarfdw', 1, 'cstar.png', 'Access Cassandra from PG', 'https://github.com/bigsql/cassandra_fdw#cassandra_fdw');

INSERT INTO projects VALUES ('presto',     2, 0, 'hub', 0, 'https://github.com/prestodb/presto/releases', 'presto', 1, 'presto.png', 'SQL Queries', 'https://prestodb.io');
INSERT INTO projects VALUES ('presto_fdw', 2, 0, 'hub', 0, 'https://github.com/bigsql/presto_fdw/releases', 'presto_fdw', 1, 'presto.png', 'Access Presto from PG', 'https://github.com/bigsql/presto_fdw#presto_fdw');

INSERT INTO projects VALUES ('mysql',      2, 0, 'hub', 0, 'https://dev.mysql.com/downloads/mysql', 'mysql', 0, 'mysql.png', 'MySQL Server', 'https://dev.mysql.com');
INSERT INTO projects VALUES ('mysql_fdw',  2, 0, 'hub', 0, 'https://github.com/EnterpriseDB/mysql_fdw/releases', 'mysql_fdw', 1, 'mysql.png', 'Access MySQL from PG', 'https://github.com/EnterpriseDb/mysql_fdw');

INSERT INTO projects VALUES ('sqlsvr',     2, 0, 'hub', 0, 'https://microsoft.com', 'sqlsvr', 0, 'sqlsvr.png', 'SQL Server Express Linux', 'https://microsoft.com');
INSERT INTO projects VALUES ('sybase',     2, 0, 'hub', 0, 'https://sap.com/products/sybase-ase.html', 'sybase', 0, 'sybase.png', 'Sybase ASE', 'https://sap.com/products/sybase-ase.html');
INSERT INTO projects VALUES ('pgtsql',     2, 0, 'hub', 0, 'https://github.com/bigsql/pgtsql/releases', 'pgtsql', 1, 'tds.png', 'Transact-SQL Procedures', 'https://github.com/bigsql/pgtsql#pgtsql');
INSERT INTO projects VALUES ('tds_fdw',    2, 0, 'hub', 0, 'https://github.com/tds-fdw/tds_fdw/releases', 'tds_fdw', 1, 'tds.png', 'SqlSvr & Sybase from PG', 'https://github.com/tds-fdw/tds_fdw/#tds-foreign-data-wrapper');

INSERT INTO projects VALUES ('plv8',       2, 0, 'hub', 0, 'https://github.com/plv8/plv8/releases', 'plv8',   1, 'v8.png', 'Javascript Stored Procedures', 'https://github.com/plv8/plv8');
INSERT INTO projects VALUES ('plpython3',  2, 0, 'hub', 0, 'https://www.postgresql.org/docs/11/plpython.html', 'plpython', 1, 'python.png', 'Python3 Stored Procedures', 'https://www.postgresql.org/docs/11/plpython.html');
INSERT INTO projects VALUES ('plperl',     2, 0, 'hub', 0, 'https://www.postgresql.org/docs/11/plperl.html', 'plperl', 1, 'perl.png', 'Perl Stored Procedures', 'https://www.postgresql.org/docs/11/plperl.html');
INSERT INTO projects VALUES ('pljava',     2, 0, 'hub', 0, 'https://github.com/tada/pljava/releases', 'pljava', 1, 'java.png', 'Java Stored Procedures', 'https://github.com/tada/pljava');

INSERT INTO projects VALUES ('oracle',     2, 0, 'hub', 0, 'https://oracle.com', 'oracle', 0, 'oracle.png', 'Oracle Express', 'https://oracle.com');
INSERT INTO projects VALUES ('orafce',     2, 0, 'hub', 0, 'https://github.com/orafce/orafce/releases', 'orafce', 1, 'orafce.png', 'Ora Built-in Packages', 'https://github.com/orafce/orafce#orafce---oracles-compatibility-functions-and-packages');
INSERT INTO projects VALUES ('pgosql',     2, 0, 'hub', 0, 'https://github.com/bigsql/pgosql/releases', 'pgosql', 1, 'sailboat.png', 'PL/SQL Procedures', 'https://github.com/bigsql/pgosql#pgosql');
INSERT INTO projects VALUES ('oracle_fdw', 2, 0, 'hub', 0, 'https://github.com/laurenz/oracle_fdw/releases', 'oracle_fdw', 1, 'oracle.png', 'Access Oracle from PG', 'https://github.com/laurenz/oracle_fdw');

INSERT INTO projects VALUES ('plprofiler', 3, 0, 'hub', 0, 'https://github.com/bigsql/plprofiler/releases', 'plprofiler', 1, 'plprofiler.png', 'Stored Procedure Profiler', 'https://github.com/bigsql/plprofiler#plprofiler');
INSERT INTO projects VALUES ('pglogical',  3, 0, 'hub', 0, 'https://github.com/2ndQuadrant/pglogical/releases', 'pglogical', 1, 'spock.png', 'Multi-Master Replication', 'https://github.com/2ndQuadrant/pglogical#pglogical-2');
INSERT INTO projects VALUES ('timescaledb',3, 0, 'hub', 0, 'https://github.com/timescale/timescaledb/releases', 'timescaledb', 1, 'timescaledb.png', 'Time Series Data', 'https://github.com/timescale/timescaledb/#timescaledb');
INSERT INTO projects VALUES ('hypopg',     3, 0, 'hub', 0, 'https://github.com/HypoPG/hypopg/releases', 'hypopg', 1, 'whatif.png', 'Hypothetical Indexes', 'https://hypopg.readthedocs.io/en/latest/');
INSERT INTO projects VALUES ('backrest',   3, 0, 'hub', 0, 'https://pgbackrest.org/release.html', 'backrest', 0, 'backrest.png', 'Backup & Restore', 'https://pgbackrest.org');
INSERT INTO projects VALUES ('badger',     3, 0, 'hub', 0, 'https://github.com/darold/pgbadger/releases', 'badger', 0, 'badger.png', 'Performance Reports', 'https://pgbadger.darold.net');
INSERT INTO projects VALUES ('patroni',    3, 0, 'hub', 0, 'https://github.com/zalando/patroni/releases', 'patroni', 0, 'patroni.png', 'High Availability', 'https://github.com/zalando/patroni');
INSERT INTO projects VALUES ('partman',    3, 0, 'hub', 0, 'https://github.com/zalando/patroni/releases', 'partman', 1, 'partman.png', 'Partition Managemnt', 'https://github.com/zalando/patroni');

INSERT INTO projects VALUES ('psycopg',    4, 0, 'hub', 0, 'http://initd.org/psycopg', 'psycopg', 0, 'python.png', 'Python Adapter', 'http://initd.org/psycopg');
INSERT INTO projects VALUES ('npgsql',     4, 0, 'hub', 0, 'https://github.com/', 'npgsql', 0, 'npgsql.png', '.NET Provider', 'https://www.npgsql.org');
INSERT INTO projects VALUES ('ruby',       4, 0, 'hub', 0, 'https://rubygems.org/gems/pg', 'ruby', 0, 'ruby.png', 'Ruby Interface', 'https://github.com');
INSERT INTO projects VALUES ('jdbc',       4, 0, 'hub', 0, 'https://jdbc.postgresql.org', 'jdbc', 0, 'java.png', 'JDBC Driver', 'https://jdbc.postgresql.org');
INSERT INTO projects VALUES ('odbc',       4, 0, 'hub', 0, 'https://www.postgresql.org/ftp/odbc/versions/msi/', 'odbc', 0, 'odbc.png', 'ODBC Driver', 'https://odbc.postgresql.org');

INSERT INTO projects VALUES ('docker',     4, 0, 'hub', 0, 'https://github.com/docker/docker-ce/releases', 'docker', 0, 'docker.png', 'Container Runtime', 'https://github.com/docker/docker-ce/#docker-ce');
INSERT INTO projects VALUES ('omnidb',     4, 8000, 'docker', 0, 'https://github.com/omnidb/omnidb/releases', 'omnidb', 0, 'omnidb.png', 'RDBMS Web Admin', 'https://github.com/omnidb/omnidb/#omnidb');
INSERT INTO projects VALUES ('pgadmin4',   4, 1234, 'docker', 0, 'https://pgadmin.org', 'pgadmin4', 0, 'pgadmin4.png', 'PG Web Admin', 'https://pgadmin.org');
INSERT INTO projects VALUES ('kubernetes', 4, 0, 'hub', 0, 'https://github.com/kubernetes/minikube/releases', 'kubernetes', 0, 'minikube.png', 'Kubernetes (MiniKube)', 'https://minikube.sigs.k8s.io/');
INSERT INTO projects VALUES ('helm',       4, 0, 'hub', 0, 'https://github.com/helm/helm/releases', 'helm', 0, 'helm.png', 'K8s Package Manager', 'https://helm.sh');
INSERT INTO projects VALUES ('pgrest',     4, 0, 'hub', 0, 'https://github.com/pgrest/pgrest/releases', 'pgrest', 0, 'restapi.png', 'RESTFUL API', 'https://github.com/pgrest/pgrest');
INSERT INTO projects VALUES ('http',       4, 0, 'hub', 0, 'https://github.com/pramsey/pgsql-http/releases', 'http',  1, 'http.png', 'HTTP Client', 'https://github.com/pramsey/pgsql-http');
INSERT INTO projects VALUES ('anon',       3, 0, 'ddlx', 0, 'https://gitlab.com/dalibo/postgresql_anonymizer/releases', 'anon', 1, 'anon.png', 'Postgres Anonymizer', 'https://gitlab.com/dalibo/postgresql_anonymizer/blob/master/README.md');
INSERT INTO projects VALUES ('ddlx',       4, 0, 'hub', 0, 'https://github.com/lacanoid/pgddl/releases', 'ddlx',  1, 'ddlx.png', 'DDL Extractor', 'https://github.com/lacanoid/pgddl#ddl-extractor-functions--for-postgresql');


CREATE TABLE releases (
  component  TEXT     NOT NULL PRIMARY KEY,
  sort_order SMALLINT NOT NULL,
  project    TEXT     NOT NULL,
  disp_name  TEXT     NOT NULL,
  doc_url    TEXT     NOT NULL,
  stage      TEXT     NOT NULL,
  FOREIGN KEY (project) REFERENCES projects(project)
);
INSERT INTO releases VALUES ('hub', 1, 'hub', '', '', 'hidden');

## PostgreSQL ###########################################
INSERT INTO releases VALUES ('pg96',              09, 'pg',            'PG 9.6',    '', 'test');
INSERT INTO releases VALUES ('pg10',              10, 'pg',            'PG 10',     '', 'test');
INSERT INTO releases VALUES ('pg11',              11, 'pg',            'PG 11',     '', 'prod');
INSERT INTO releases VALUES ('pg12',              12, 'pg',            'PG 12',     '', 'prod');
INSERT INTO releases VALUES ('pg',                12, 'pg',            'PostgreSQL','', 'prod' );


## Compatibility & Integration ##########################
INSERT INTO releases VALUES ('pgtsql-pg11',        1, 'pgtsql',        'T-SQL',      '', 'prod');
INSERT INTO releases VALUES ('sqlsvr',             1, 'sqlsvr',        'SQL Server', '', 'test');
INSERT INTO releases VALUES ('sybase',             1, 'sybase',        'SAP/Sybase', '', 'test');
INSERT INTO releases VALUES ('tds_fdw-pg11',       1, 'tds_fdw',       'TDS FDW',    '', 'prod');
INSERT INTO releases VALUES ('pgosql-pg11',        1, 'pgosql',        'OSQL',       '', 'test');
INSERT INTO releases VALUES ('orafce-pg11',        1, 'orafce',        'OraFCE',     '', 'prod');
INSERT INTO releases VALUES ('oracle_fdw-pg11',    1, 'oracle_fdw',    'Oracle FDW', '', 'prod');
INSERT INTO releases VALUES ('oracle',             1, 'oracle',        'Oracle',     '', 'test');
INSERT INTO releases VALUES ('plpython-pg11',      1, 'plpython3',     'PL/Python',  '', 'prod');
INSERT INTO releases VALUES ('plperl-pg11',        1, 'plperl',        'PL/Perl',    '', 'prod');
INSERT INTO releases VALUES ('plv8-pg11',          1, 'plv8',          'PL/V8',      '', 'prod');
INSERT INTO releases VALUES ('pljava-pg11',        1, 'pljava',        'PL/Java',    '', 'prod');
INSERT INTO releases VALUES ('mysql_fdw-pg11',     1, 'mysql_fdw',     'MySQL FDW',  '', 'prod');
INSERT INTO releases VALUES ('mysql',              1, 'mysql',         'MySQL',      '', 'test');
INSERT INTO releases VALUES ('cassandra',          1, 'cassandra',     'Cassandra',  '', 'test');
INSERT INTO releases VALUES ('cassandra_fdw-pg11', 1, 'cassandra_fdw', 'C* FDW',     '', 'prod');
INSERT INTO releases VALUES ('presto',             1, 'presto',        'Presto',     '', 'prod');
INSERT INTO releases VALUES ('presto_fdw-pg11',    1, 'presto_fdw',    'Presto FDW', '', 'prod');

## Performance, Scalability, Availability, & Security ###
INSERT INTO releases VALUES ('timescaledb-pg11',   1, 'timescaledb',   'TimescaleDB','', 'prod');
INSERT INTO releases VALUES ('pglogical-pg11',     1, 'pglogical',     'pgLogical',  '', 'prod');
INSERT INTO releases VALUES ('docker',             1, 'docker',        'Docker',     '', 'prod');
INSERT INTO releases VALUES ('kubernetes',         1, 'kubernetes',    'K8s',        '', 'test');
INSERT INTO releases VALUES ('helm',               1, 'helm',          'Helm',       '', 'test');
INSERT INTO releases VALUES ('patroni',            1, 'patroni',       'Patroni',    '', 'test');
INSERT INTO releases VALUES ('backrest',           1, 'backrest',      'pgBackRest', '', 'test');
INSERT INTO releases VALUES ('badger',             1, 'badger',        'pgBadger',   '', 'prod');
INSERT INTO releases VALUES ('partman-pg11',       1, 'partman',       'pgPartman',  '', 'prod');
INSERT INTO releases VALUES ('hypopg-pg11',        1, 'hypopg',        'HypoPG',     '', 'prod');
INSERT INTO releases VALUES ('plprofiler-pg11',    1, 'plprofiler',    'plProfiler', '', 'prod');
INSERT INTO releases VALUES ('ddlx-pg11',          1, 'ddlx',          'DDLeXtact',  '', 'prod');
INSERT INTO releases VALUES ('http-pg11',          1, 'http',          'HTTP Client','', 'prod');
INSERT INTO releases VALUES ('anon-pg11',          1, 'anon',          'Anonymizer', '', 'prod');

## Applications & Administration ########################
INSERT INTO releases VALUES ('pgrest',             1, 'pgrest',        'Data API',   '', 'prod');
INSERT INTO releases VALUES ('bouncer',            1, 'bouncer',       'pgBouncer',  '', 'test');
INSERT INTO releases VALUES ('psycopg',            1, 'psycopg',       'psycopg',    '', 'prod');
INSERT INTO releases VALUES ('ruby',               1, 'ruby',          'ruby',       '', 'prod');
INSERT INTO releases VALUES ('npgsql',             1, 'npgsql',        '.net PG',    '', 'prod');
INSERT INTO releases VALUES ('jdbc',               1, 'jdbc',          'JDBC',       '', 'prod');
INSERT INTO releases VALUES ('odbc',               1, 'odbc',          'ODBC',       '', 'prod');
INSERT INTO releases VALUES ('omnidb',             1, 'omnidb',        'OmniDB',     '', 'test');
INSERT INTO releases VALUES ('pgadmin4',           1, 'pgadmin4',      'pgAdmin 4',   '', 'test');

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

INSERT INTO versions VALUES ('pg10',               '10.8',     'amd, arm',       1, '20191114', '');

INSERT INTO versions VALUES ('pg11',               '11.6-6',   'amd, arm',       1, '20191114', '');
INSERT INTO versions VALUES ('pg11',               '11.6-5',   'amd, arm',       0, '20191114', '');
INSERT INTO versions VALUES ('pg11',               '11.6-4',   'amd, arm',       0, '20191114', '');

INSERT INTO versions VALUES ('pg12',               '12.1-6',   'amd, arm',       1, '20191114', '');
INSERT INTO versions VALUES ('pg12',               '12.1-5',   'amd, arm',       0, '20191114', '');
INSERT INTO versions VALUES ('pg12',               '12.1-4',   'amd, arm',       0, '20191114', '');

INSERT INTO versions VALUES ('pg',                 '12.1-6',   'amd, arm',       1, '20191114', '');

INSERT INTO versions VALUES ('partman-pg11',       '4.2.2-1',  'amd, arm',       1, '20191123', 'pg11');

INSERT INTO versions VALUES ('hypopg-pg11',        '1.1.3-1',  'amd, arm',       1, '20191123', 'pg11');

INSERT INTO versions VALUES ('orafce-pg11',        '3.8.0-1',  'amd, arm',       1, '20190522', 'pg11');

INSERT INTO versions VALUES ('pgosql-pg11',        '2.0-1',    'amd',            1, '20191211', 'pg11');

INSERT INTO versions VALUES ('sqlsvr',             '2.0',      'amd',            1, '20191010', '');
INSERT INTO versions VALUES ('sybase',             '1.0',      'amd',            1, '20191010', '');
INSERT INTO versions VALUES ('pgtsql-pg11',        '3.0-1',    'amd, arm',       1, '20191119', 'pg11');
INSERT INTO versions VALUES ('tds_fdw-pg11',       '2.1.0-1',  'amd, arm',       1, '20191202', 'pg11');

INSERT INTO versions VALUES ('pglogical-pg11',     '2.2.2-1',  'amd, arm',       1, '20190725', 'pg11');

INSERT INTO versions VALUES ('plv8-pg11',          '2.3.14-1', 'amd',            1, '20200109', 'pg11');
INSERT INTO versions VALUES ('plpython-pg11',      '11',       'amd',            1, '20191114', 'pg11');
INSERT INTO versions VALUES ('plperl-pg11',        '11',       'amd',            1, '20191114', 'pg11');
INSERT INTO versions VALUES ('pljava-pg11',        '1.5.5-1',  'amd',            1, '20191104', 'pg11');

INSERT INTO versions VALUES ('oracle',             '11.2.0',   'amd',            1, '20191010', '');
INSERT INTO versions VALUES ('oracle_fdw-pg11',    '2.2.0-1',  'amd',            1, '20191010', 'pg11');

INSERT INTO versions VALUES ('mysql',              '8.0.18',   'amd',            1, '20191014', '');
INSERT INTO versions VALUES ('mysql_fdw-pg11',     '2.5.3-1',  'amd',            1, '20190927', 'pg11');

INSERT INTO versions VALUES ('plprofiler-pg11',    '4.1-1',    'amd, arm',       1, '20190823', 'pg11');

INSERT INTO versions VALUES ('ddlx-pg11',          '0.15-1',   'amd, arm',       1, '20191024', 'pg11');

INSERT INTO versions VALUES ('http-pg11',          '1.3.1-1',  'amd, arm',       1, '20191225', 'pg11');

INSERT INTO versions VALUES ('anon-pg11',          '0.5.0-1',  'amd, arm',       1, '20191109', 'pg11');

INSERT INTO versions VALUES ('timescaledb-pg11',   '1.5.1-1',  'amd, arm',       1, '20191112', 'pg11');

INSERT INTO versions VALUES ('cassandra',          '3.11.5',   '',               1, '20191029', '');
INSERT INTO versions VALUES ('cassandra_fdw-pg11', '3.1.5-1',  'amd',            1, '20191230', 'pg11');

INSERT INTO versions VALUES ('presto',             '0.229',    '',               1, '20191115', '');
INSERT INTO versions VALUES ('presto_fdw-pg11',    '3.2-1',    'amd',            1, '20191230', 'pg11');

INSERT INTO versions VALUES ('badger',             '11.1-1',   '',               1, '20190916', '');
INSERT INTO versions VALUES ('pgrest',             '0.0.7-1',  'amd, arm',       0, '20130813', '');
INSERT INTO versions VALUES ('bouncer',            '1.12.0-1', 'amd, arm',       1, '20191017', '');

INSERT INTO versions VALUES ('psycopg',            '2.8.4',    '',               1, '20191020', '');
INSERT INTO versions VALUES ('ruby',               '1.2.0',    '',               1, '20191224', '');
INSERT INTO versions VALUES ('npgsql',             '3.1.0',    '',               1, '20191201', '');
INSERT INTO versions VALUES ('jdbc',               '42.2.9',   '',               1, '20191206', '');
INSERT INTO versions VALUES ('odbc',               '12.00-1',  'amd, arm',       1, '20191011', '');

INSERT INTO versions VALUES ('backrest',           '2.20-1',   'amd, arm',       1, '20191218', '');

INSERT INTO versions VALUES ('helm',               '3.0.2',    'amd, arm',       1, '20191218', '');

INSERT INTO versions VALUES ('kubernetes',         '1.6.2',    'amd, arm',       1, '20191220', '');

INSERT INTO versions VALUES ('docker',             '19.03.5',  'amd, arm',       1, '20191113', '');

INSERT INTO versions VALUES ('omnidb',             '2.17-1',   'docker',         1, '20191205', '');
INSERT INTO versions VALUES ('pgadmin4',           '4.17',     'docker',         1, '20190109', '');

INSERT INTO versions VALUES ('patroni',            '1.6.3',    '',               1, '20191205', '');


CREATE VIEW v_versions AS
  SELECT p.category as cat, c.description as cat_desc, c.short_desc as cat_short_desc,
         p.image_file, r.component, r.project, r.stage, r.disp_name as release_name,
         v.version, p.sources_url, p.project_url, v.platform, 
         v.is_current, v.release_date, p.description as proj_desc
    FROM categories c, projects p, releases r, versions v
   WHERE c.category = p.category
     AND p.project = r.project
     AND r.component = v.component;
