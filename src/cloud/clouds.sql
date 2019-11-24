
DROP SCHEMA IF EXISTS bigsql CASCADE;
CREATE SCHEMA bigsql;

CREATE TABLE bigsql.clouds (
  cloud_id      SERIAL  NOT NULL PRIMARY KEY,
  cloud_name    TEXT    NOT NULL
);

INSERT INTO bigsql.clouds VALUES
  (1, 'aws');


CREATE TABLE bigsql.regions (
  region_id     SERIAL     NOT NULL PRIMARY KEY,
  cloud_id      INTEGER    NOT NULL REFERENCES bigsql.clouds(cloud_id),
  region_name   TEXT       NOT NULL
);

INSERT INTO bigsql.regions VALUES
  (1, 1, 'us-east-1'), 
  (2, 1, 'us-east-2'),
  (3, 1, 'us-west-1'),
  (4, 1, 'us-west-2');


CREATE TABLE bigsql.images (
  image_id           SERIAL  NOT NULL PRIMARY KEY,
  region_id          INTEGER NOT NULL REFERENCES bigsql.regions(region_id),
  image_description  TEXT  NOT NULL,
  image_name         TEXT  NOT NULL
);
INSERT INTO bigsql.images VALUES 
  (1, 4, 'Amazon Linux 2 AMI (HVM) - SSD Volume Type',      'ami-04b762b4289fba92b'),
  (2, 4, 'Ubuntu Server 18.04 LTS (HVM) - SSD Volume Type', 'ami-06f2f779464715dc5');


CREATE TABLE bigsql.zones (
  zone_id            SERIAL   PRIMARY KEY,
  region_id          INTEGER  NOT NULL REFERENCES bigsql.regions(region_id),
  zone_name          TEXT     NOT NULL
);

INSERT INTO bigsql.zones VALUES
  (1, 1, 'us-east-1a'), 
  (2, 1, 'us-east-1b');


CREATE TABLE bigsql.instance_types (
  instance_type_id  SERIAL  PRIMARY KEY,
  cloud_id          INTEGER NOT NULL REFERENCES bigsql.clouds(cloud_id),
  type_name         TEXT    NOT NULL,
  v_cpu             INTEGER NOT NULL,
  memory_gib        INTEGER NOT NULL,
  storage_gb        INTEGER NOT NULL,
  instance_storage  TEXT    NOT NULL,
  network           TEXT    NOT NULL
);

INSERT INTO bigsql.instance_types VALUES
  (1, 1, 'm5d.large',     2,   8,   75, '1 x 75  (SSD)', 'up to 10 Gigabit'),
  (2, 1, 'm5d.xlarge',    4,  16,  150, '1 x 150 (SSD)', 'up to 10 Gigabit'),
  (3, 1, 'm5d.2xlarge',   8,  32,  300, '1 x 300 (SSD)', 'up to 10 Gigabit'),
  (4, 1, 'm5d.4xlarge',  16,  64,  600, '2 x 300 (SSD)', 'up to 10 Gigabit'),
  (5, 1, 'm5d.12xlarge', 48, 192, 1800, '2 x 900 (SSD)', '10 Gigabit'),
  (6, 1, 'm5d.24xlarge', 96, 384, 3600, '4 x 900 (SSD)', '20 Gigabit');


CREATE TABLE bigsql.instances (
  instance_id        SERIAL PRIMARY KEY,
  zone_id            INTEGER NOT NULL REFERENCES bigsql.zones(zone_id),
  instance_name      TEXT,
  instance_type_id   INTEGER      NOT NULL REFERENCES bigsql.instance_types(instance_type_id),
  instance_state     TEXT         NOT NULL,
  launch_time        TIMESTAMP WITH TIME ZONE NOT NULL,
  status_checks      TEXT,
  alarm_status       TEXT,
  public_dns         TEXT,
  public_ip          TEXT,
  private_dns        TEXT,
  private_ips        TEXT
);


CREATE VIEW bigsql.v_instances AS
  SELECT i.instance_id, i.zone_id , i.instance_name , i.instance_type_id
       , t.cloud_id, t.type_name, t.v_cpu, t.memory_gib
       , t.storage_gb, t.instance_storage, t.network
       , z.region_id, z.zone_name
       , r.region_name
       , m.image_description, m.image_name
       , c.cloud_name
    FROM bigsql.instances i
       , bigsql.instance_types t
       , bigsql.zones z
       , bigsql.regions r
       , bigsql.clouds c
       , bigsql.images m
   WHERE i.instance_type_id = t.instance_type_id
     AND i.zone_id = z.zone_id
     AND z.region_id = r.region_id
     AND r.cloud_id = c.cloud_id
     AND r.region_id = m.region_id;

