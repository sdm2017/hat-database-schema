--liquibase formatted sql

--changeset hubofallthings:applications context:structuresonly

CREATE SEQUENCE hat.application_seq;

CREATE TABLE hat.applications (
  application_id  INTEGER   NOT NULL DEFAULT nextval('hat.application_seq') PRIMARY KEY,
  date_created    TIMESTAMP NOT NULL DEFAULT (NOW()),
  date_setup      TIMESTAMP,
  title           VARCHAR   NOT NULL,
  description     VARCHAR   NOT NULL,
  logo_url        VARCHAR   NOT NULL,
  url             VARCHAR   NOT NULL,
  auth_url        VARCHAR   NOT NULL,
  browser         BOOLEAN   NOT NULL,
  category        VARCHAR   NOT NULL,
  setup           BOOLEAN   NOT NULL,
  login_available BOOLEAN   NOT NULL
);

--rollback DROP TABLE hat.applications;
--rollback DROP SEQUENCE hat.application_seq;

--changeset hubofallthings:presetApplications context:data,testdata

INSERT INTO hat.applications (title, description, logo_url, url, auth_url, browser, category, setup, login_available)
VALUES ('MarketSquare', 'Community and Public space for HATs', '/assets/images/MarketSquare-logo.svg',
        'https://marketsquare.hubofallthings.com', '/authenticate/hat', FALSE, 'app', TRUE, TRUE);

INSERT INTO hat.applications (title, description, logo_url, url, auth_url, browser, category, setup, login_available)
VALUES ('Rumpel', 'Private hyperdata browser for your HAT data', '/assets/images/Rumpel-logo.svg',
        'https://rumpel.hubofallthings.com', '/users/authenticate', TRUE, 'app', TRUE, TRUE);

INSERT INTO hat.applications (title, description, logo_url, url, auth_url, browser, category, setup, login_available)
VALUES ('Hatters', 'HATs, Apps and HAT2HAT exchanges', '/assets/images/Hatters-logo.svg',
        'https://hatters.hubofallthings.com', '/authenticate/hat', FALSE, 'app', TRUE, TRUE);

INSERT INTO hat.applications (title, description, logo_url, url, auth_url, browser, category, setup, login_available)
VALUES ('Rumpel', 'Private hyperdata browser for your HAT data', '/assets/images/Rumpel-logo.svg',
        'http://rumpel-stage.hubofallthings.com.s3-website-eu-west-1.amazonaws.com', '/users/authenticate', TRUE,
        'testapp', TRUE, TRUE);

INSERT INTO hat.applications (title, description, logo_url, url, auth_url, browser, category, setup, login_available)
VALUES ('Facebook', 'Pull in all of your Facebook Data', 'https://rumpel.hubofallthings.com/icons/facebook-plug.png',
        'https://social-plug.hubofallthings.com', '/hat/authenticate', FALSE, 'dataplug', TRUE, TRUE);

INSERT INTO hat.applications (title, description, logo_url, url, auth_url, browser, category, setup, login_available)
VALUES ('Calendar', 'Paste an iCal link to any of your calendars for it to be added to your HAT',
        'https://rumpel.hubofallthings.com/icons/calendar-plug.svg', 'https://calendar-plug.hubofallthings.com', '',
        FALSE, 'dataplug', TRUE, FALSE);

INSERT INTO hat.applications (title, description, logo_url, url, auth_url, browser, category, setup, login_available)
VALUES ('Photos', 'Import your best moments from Dropbox into your HAT',
        'https://rumpel.hubofallthings.com/icons/photos-plug.svg', 'https://photos-plug.hubofallthings.com', '', FALSE,
        'dataplug', TRUE, FALSE);

INSERT INTO hat.applications (title, description, logo_url, url, auth_url, browser, category, setup, login_available)
VALUES ('RumpelLite', 'Your location coming in directly from your iOS device into your HAT!',
        'https://rumpel.hubofallthings.com/icons/location-plug.svg', 'https://itunes.apple.com',
        '/gb/app/rumpel-lite/id1147137249', FALSE, 'dataplug', TRUE, FALSE);

--rollback DELETE FROM hat.applications WHERE title IN ('MarketSquare', 'Rumpel', 'Hatters', 'Facebook', 'Calendar', 'Photos', 'RumpelLite');

--changeset hubofallthings:eventCorrectIdSequence context:structuresonly

ALTER TABLE hat.events_event ALTER COLUMN id SET DEFAULT nextval('hat.entity_id_seq');

--rollback ALTER TABLE hat.events_event ALTER COLUMN id SET DEFAULT nextval('hat.events_event_id_seq'),;

--changeset hubofallthings:deletableData context:structuresonly

ALTER TABLE hat.data_field
  ADD COLUMN deleted BOOL NOT NULL DEFAULT (FALSE);
ALTER TABLE hat.data_record
  ADD COLUMN deleted BOOL NOT NULL DEFAULT (FALSE);
ALTER TABLE hat.data_table
  ADD COLUMN deleted BOOL NOT NULL DEFAULT (FALSE);
ALTER TABLE hat.data_value
  ADD COLUMN deleted BOOL NOT NULL DEFAULT (FALSE);
ALTER TABLE hat.data_tabletotablecrossref
  ADD COLUMN deleted BOOL NOT NULL DEFAULT (FALSE);

--rollback ALTER TABLE hat.data_field DROP COLUMN deleted;
--rollback ALTER TABLE hat.data_record DROP COLUMN deleted;
--rollback ALTER TABLE hat.data_table DROP COLUMN deleted;
--rollback ALTER TABLE hat.data_value DROP COLUMN deleted;
--rollback ALTER TABLE hat.data_tabletotablecrossref DROP COLUMN deleted;

--changeset hubofallthings:deletableDataNestedTAbles context:structuresonly

DROP VIEW hat.data_table_tree;

CREATE VIEW hat.data_table_tree AS WITH RECURSIVE recursive_table(id, date_created, last_updated, name, source_name, deleted, table1) AS (
  SELECT
    b.id,
    b.date_created,
    b.last_updated,
    b.name,
    b.source_name,
    b.deleted,
    b2b.table1,
    ARRAY [b.id] AS path,
    b.id         AS root_table
  FROM hat.data_table b
    LEFT JOIN hat.data_tabletotablecrossref b2b
      ON b.id = b2b.table2
  UNION ALL
  SELECT
    b.id,
    b.date_created,
    b.last_updated,
    b.name,
    b.source_name,
    b.deleted,
    b2b.table1,
    (r_b.path || b.id),
    path [1] AS root_table
  FROM recursive_table r_b, hat.data_table b
    LEFT JOIN hat.data_tabletotablecrossref b2b
      ON b.id = b2b.table2
  WHERE b2b.table1 = r_b.id
)
SELECT *
FROM recursive_table;

--rollback DROP VIEW hat.data_table_tree;

--rollback CREATE VIEW hat.data_table_tree AS WITH RECURSIVE recursive_table(id, date_created, last_updated, name, source_name, table1) AS (
--rollback   SELECT
--rollback     b.id,
--rollback     b.date_created,
--rollback     b.last_updated,
--rollback     b.name,
--rollback     b.source_name,
--rollback     b2b.table1,
--rollback     ARRAY [b.id] AS path,
--rollback     b.id         AS root_table
--rollback   FROM hat.data_table b
--rollback     LEFT JOIN hat.data_tabletotablecrossref b2b
--rollback       ON b.id = b2b.table2
--rollback   UNION ALL
--rollback   SELECT
--rollback     b.id,
--rollback     b.date_created,
--rollback     b.last_updated,
--rollback     b.name,
--rollback     b.source_name,
--rollback     b2b.table1,
--rollback     (r_b.path || b.id),
--rollback     path [1] AS root_table
--rollback   FROM recursive_table r_b, hat.data_table b
--rollback     LEFT JOIN hat.data_tabletotablecrossref b2b
--rollback       ON b.id = b2b.table2
--rollback   WHERE b2b.table1 = r_b.id
--rollback )
--rollback SELECT *
--rollback FROM recursive_table;

--changeset hubofallthings:updateDataplugIcons context:data,testdata runOnChange:true

UPDATE hat.applications SET logo_url = '/assets/images/Rumpel-logo.svg' WHERE title = 'Rumpel';
UPDATE hat.applications SET logo_url = 'https://rumpel.hubofallthings.com/assets/icons/facebook-plug.png' WHERE title = 'Facebook';
UPDATE hat.applications SET logo_url = 'https://rumpel.hubofallthings.com/assets/icons/calendar-plug.svg', login_available = TRUE WHERE title = 'Calendar';
UPDATE hat.applications SET logo_url = 'https://rumpel.hubofallthings.com/assets/icons/photos-plug.svg', login_available = TRUE WHERE title = 'Photos';
UPDATE hat.applications SET logo_url = 'https://rumpel.hubofallthings.com/assets/icons/location-plug.svg' WHERE title = 'RumpelLite';

UPDATE hat.applications SET auth_url = '/hat/authenticate' WHERE title = 'Calendar';
UPDATE hat.applications SET auth_url = '/hat/authenticate' WHERE title = 'Photos';

--changeset hubofallthings:dataStatsLog context:structuresonly

CREATE SEQUENCE hat.data_stats_seq;

CREATE TABLE hat.data_stats_log (
  stats_id INT8  NOT NULL DEFAULT nextval('hat.data_stats_seq') PRIMARY KEY,
  stats    JSONB NOT NULL
);

--changeset hubofallthings:baseTableIndexes context:structuresonly runOnChange:true

DROP INDEX IF EXISTS hat.data_value_field;
DROP INDEX IF EXISTS hat.data_value_record;
DROP INDEX IF EXISTS hat.data_field_table;
DROP INDEX IF EXISTS hat.data_table_name;
DROP INDEX IF EXISTS hat.data_table_source_name;

CREATE INDEX data_value_field ON hat.data_value(field_id ASC);
CREATE INDEX data_value_record ON hat.data_value(record_id ASC);
CREATE INDEX data_field_table ON hat.data_field(table_id_fk ASC);
CREATE INDEX data_table_name ON hat.data_table(name);
CREATE INDEX data_table_source_name ON hat.data_table(source_name);

--rollback DROP INDEX IF EXISTS hat.data_value_field;
--rollback DROP INDEX IF EXISTS hat.data_value_record;
--rollback DROP INDEX IF EXISTS hat.data_field_table;
--rollback DROP INDEX IF EXISTS hat.data_table_name;
--rollback DROP INDEX IF EXISTS hat.data_table_source_name;

--changeset hubofallthings:rumpelLiteApp context:structuresonly runOnChange:true

DELETE FROM hat.applications WHERE title = 'RumpelLite';

INSERT INTO hat.applications (title, description, logo_url, url, auth_url, browser, category, setup, login_available)
VALUES ('RumpelLite', 'Mobile hyperdata browser for your HAT data', '/assets/images/Rumpel-logo.svg',
        'rumpellocationtrackerapp://rumpellocationtrackerapphost', '/', TRUE, 'app', TRUE, TRUE);

--rollback DELETE FROM hat.applications WHERE title = 'RumpelLite';

--changeset hubofallthings:userMailTokens context:structuresonly runOnChange:true

CREATE TABLE IF NOT EXISTS hat.user_mail_tokens (
  id              VARCHAR   NOT NULL PRIMARY KEY,
  email           VARCHAR   NOT NULL,
  expiration_time TIMESTAMP NOT NULL,
  is_signup       BOOLEAN   NOT NULL
);

--rollback DROP TABLE user_mail_tokens;

--changeset hubofallthings:fileMetadata context:structuresonly

CREATE TABLE hat.hat_file (
  id           VARCHAR   NOT NULL PRIMARY KEY,
  name         VARCHAR   NOT NULL,
  source       VARCHAR   NOT NULL,
  date_created TIMESTAMP NOT NULL DEFAULT (now()),
  last_updated TIMESTAMP NOT NULL DEFAULT (now()),
  tags         TEXT [],
  title        VARCHAR,
  description  VARCHAR,
  source_url   VARCHAR,
  status       JSONB   NOT NULL
);

--rollback DROP TABLE hat.hat_file;

--changeset hubofallthings:fileAccessPermissions context:structuresonly

CREATE TABLE hat.hat_file_access (
  file_id VARCHAR NOT NULL REFERENCES hat.hat_file(id),
  user_id UUID NOT NULL REFERENCES hat.user_user(user_id),
  content BOOL NOT NULL DEFAULT FALSE,
  PRIMARY KEY (file_id, user_id)
);

--rollback DROP TABLE hat.hat_file_access;

--changeset hubofallthings:fileAccessAllowPublic context:structuresonly

ALTER TABLE hat.hat_file ADD COLUMN content_public BOOLEAN NOT NULL DEFAULT(FALSE);
--rollback ALTER TABLE hat.hat_file DROP COLUMN content_public;

