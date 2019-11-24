
DROP TABLE IF EXISTS credentials;
DROP TABLE IF EXISTS defaults;

DROP TABLE IF EXISTS settings;
CREATE TABLE settings (
  section            TEXT      NOT NULL,
  s_key              TEXT      NOT NULL,
  s_value            TEXT      NOT NULL,
  PRIMARY KEY (section, s_key)
);
INSERT INTO settings VALUES ('GLOBAL', 'REPO', 'https://s3.amazonaws.com/pgcentral');


DROP TABLE IF EXISTS groups;
DROP TABLE IF EXISTS group_hosts;

DROP TABLE IF EXISTS hosts;
CREATE TABLE hosts (
  host_id            INTEGER PRIMARY KEY,
  host               TEXT NOT NULL,
  name               TEXT UNIQUE,
  last_update_utc    DATETIME,
  unique_id          TEXT
);
INSERT INTO hosts (host) VALUES ('localhost');


DROP TABLE IF EXISTS components;
CREATE TABLE components (
  component          TEXT     NOT NULL PRIMARY KEY,
  project            TEXT     NOT NULL,
  version            TEXT     NOT NULL,
  platform           TEXT     NOT NULL,
  port               INTEGER  NOT NULL,
  status             TEXT     NOT NULL,
  install_dt         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  autostart          TEXT,
  datadir            TEXT,
  logdir             TEXT,
  pidfile            TEXT,
  svcname            TEXT,
  svcuser            TEXT
);

