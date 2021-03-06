--liquibase formatted sql

--changeset hubofallthings:hatschema context:structuresonly

CREATE SCHEMA IF NOT EXISTS hat;

SET search_path TO hat,public;

CREATE SEQUENCE hat.entity_id_seq;

CREATE TABLE hat.things_thing (
  id           INTEGER   NOT NULL DEFAULT nextval('hat.entity_id_seq'),
  date_created TIMESTAMP NOT NULL,
  last_updated TIMESTAMP NOT NULL,
  name         VARCHAR   NOT NULL,
  CONSTRAINT things_thing_pkey PRIMARY KEY (id)
);

CREATE SEQUENCE hat.system_unitofmeasurement_id_seq;

CREATE TABLE hat.system_unitofmeasurement (
  id           INTEGER   NOT NULL DEFAULT nextval('hat.system_unitofmeasurement_id_seq'),
  date_created TIMESTAMP NOT NULL,
  last_updated TIMESTAMP NOT NULL,
  name         VARCHAR   NOT NULL UNIQUE,
  description  TEXT,
  symbol       VARCHAR,
  CONSTRAINT system_unitofmeasurement_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.system_unitofmeasurement_id_seq OWNED BY hat.system_unitofmeasurement.id;

CREATE SEQUENCE hat.system_type_id_seq;

CREATE TABLE hat.system_type (
  id           INTEGER   NOT NULL DEFAULT nextval('hat.system_type_id_seq'),
  date_created TIMESTAMP NOT NULL,
  last_updated TIMESTAMP NOT NULL,
  name         VARCHAR   NOT NULL UNIQUE,
  description  TEXT,
  CONSTRAINT system_type_pk PRIMARY KEY (id)
);


ALTER SEQUENCE hat.system_type_id_seq OWNED BY hat.system_type.id;

CREATE SEQUENCE hat.things_systemtypecrossref_id_seq;

CREATE TABLE hat.things_systemtypecrossref (
  id                INTEGER      NOT NULL DEFAULT nextval('hat.things_systemtypecrossref_id_seq'),
  date_created      TIMESTAMP    NOT NULL,
  last_updated      TIMESTAMP    NOT NULL,
  thing_id          INTEGER      NOT NULL,
  system_type_id    INTEGER      NOT NULL,
  relationship_type VARCHAR(100) NOT NULL,
  is_current        BOOLEAN      NOT NULL,
  CONSTRAINT things_systemtypecrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.things_systemtypecrossref_id_seq OWNED BY hat.things_systemtypecrossref.id;

CREATE INDEX things_thingpropertycrossref_thing_id
ON hat.things_systemtypecrossref USING BTREE
(thing_id);

CREATE INDEX things_thingpropertycrossref_thing_property_id
ON hat.things_systemtypecrossref USING BTREE
(system_type_id);

CREATE SEQUENCE hat.system_typetotypecrossref_id_seq;

CREATE TABLE hat.system_typetotypecrossref (
  id                INTEGER      NOT NULL DEFAULT nextval('hat.system_typetotypecrossref_id_seq'),
  date_created      TIMESTAMP    NOT NULL,
  last_updated      TIMESTAMP    NOT NULL,
  type_one_id       INTEGER      NOT NULL,
  type_two_id       INTEGER      NOT NULL,
  relationship_type VARCHAR(100) NOT NULL,
  CONSTRAINT system_typetotypecrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.system_typetotypecrossref_id_seq OWNED BY hat.system_typetotypecrossref.id;

CREATE INDEX system_typetotypecrossref_type_one_id
ON hat.system_typetotypecrossref USING BTREE
(type_one_id);

CREATE INDEX system_typetotypecrossref_type_two_id
ON hat.system_typetotypecrossref USING BTREE
(type_two_id);

CREATE SEQUENCE hat.system_relationshiprecord_id_seq;

CREATE TABLE hat.system_relationshiprecord (
  id           INTEGER   NOT NULL DEFAULT nextval('hat.system_relationshiprecord_id_seq'),
  date_created TIMESTAMP NOT NULL,
  last_updated TIMESTAMP NOT NULL,
  name         VARCHAR   NOT NULL,
  CONSTRAINT system_relationshiprecord_pk PRIMARY KEY (id)
);


ALTER SEQUENCE hat.system_relationshiprecord_id_seq OWNED BY hat.system_relationshiprecord.id;

CREATE SEQUENCE hat.things_thingtothingcrossref_id_seq;

CREATE TABLE hat.things_thingtothingcrossref (
  id                    INTEGER      NOT NULL DEFAULT nextval('hat.things_thingtothingcrossref_id_seq'),
  date_created          TIMESTAMP    NOT NULL,
  last_updated          TIMESTAMP    NOT NULL,
  thing_one_id          INTEGER      NOT NULL,
  thing_two_id          INTEGER      NOT NULL,
  relationship_type     VARCHAR(100) NOT NULL,
  is_current            BOOLEAN      NOT NULL,
  relationshiprecord_id INTEGER      NOT NULL,
  CONSTRAINT things_thingtothingcrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.things_thingtothingcrossref_id_seq OWNED BY hat.things_thingtothingcrossref.id;

CREATE INDEX things_thingtothingcrossref_thing_one_id
ON hat.things_thingtothingcrossref USING BTREE
(thing_one_id);

CREATE INDEX things_thingtothingcrossref_thing_two_id
ON hat.things_thingtothingcrossref USING BTREE
(thing_two_id);

CREATE SEQUENCE hat.system_relationshiprecordtorecordcrossref_id_seq;

CREATE TABLE hat.system_relationshiprecordtorecordcrossref (
  id                     INTEGER      NOT NULL DEFAULT nextval('hat.system_relationshiprecordtorecordcrossref_id_seq'),
  date_created           TIMESTAMP    NOT NULL,
  last_updated           TIMESTAMP    NOT NULL,
  relationshiprecord_id1 INTEGER      NOT NULL,
  relationshiprecord_id2 INTEGER      NOT NULL,
  relationship_type      VARCHAR(100) NOT NULL,
  CONSTRAINT system_relationshiprecordtorecordcrossref_pk PRIMARY KEY (id)
);


ALTER SEQUENCE hat.system_relationshiprecordtorecordcrossref_id_seq OWNED BY hat.system_relationshiprecordtorecordcrossref.id;

CREATE SEQUENCE hat.system_propertyrecord_id_seq;

CREATE TABLE hat.system_propertyrecord (
  id           INTEGER   NOT NULL DEFAULT nextval('hat.system_propertyrecord_id_seq'),
  date_created TIMESTAMP NOT NULL,
  last_updated TIMESTAMP NOT NULL,
  name         VARCHAR   NOT NULL,
  CONSTRAINT system_propertyrecord_pk PRIMARY KEY (id)
);


ALTER SEQUENCE hat.system_propertyrecord_id_seq OWNED BY hat.system_propertyrecord.id;

CREATE SEQUENCE hat.system_property_id_seq;

CREATE TABLE hat.system_property (
  id                   INTEGER   NOT NULL DEFAULT nextval('hat.system_property_id_seq'),
  date_created         TIMESTAMP NOT NULL,
  last_updated         TIMESTAMP NOT NULL,
  name                 VARCHAR   NOT NULL,
  description          TEXT,
  type_id              INTEGER   NOT NULL,
  unitofmeasurement_id INTEGER   NOT NULL,
  CONSTRAINT system_property_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.system_property_id_seq OWNED BY hat.system_property.id;

CREATE SEQUENCE hat.system_eventlog_id_seq;

CREATE TABLE hat.system_eventlog (
  id         INTEGER      NOT NULL DEFAULT nextval('hat.system_eventlog_id_seq'),
  event_type VARCHAR(45)  NOT NULL,
  date       DATE         NOT NULL,
  time       TIME         NOT NULL,
  creator    VARCHAR(100) NOT NULL,
  command    VARCHAR(100) NOT NULL,
  result     VARCHAR(45)  NOT NULL,
  CONSTRAINT system_eventlog_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.system_eventlog_id_seq OWNED BY hat.system_eventlog.id;

CREATE SEQUENCE hat.people_persontopersonrelationshiptype_id_seq;

CREATE TABLE hat.people_persontopersonrelationshiptype (
  id           INTEGER      NOT NULL DEFAULT nextval('hat.people_persontopersonrelationshiptype_id_seq'),
  date_created TIMESTAMP    NOT NULL,
  last_updated TIMESTAMP    NOT NULL,
  name         VARCHAR(100) NOT NULL,
  description  TEXT,
  CONSTRAINT people_persontopersonrelationshiptype_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.people_persontopersonrelationshiptype_id_seq OWNED BY hat.people_persontopersonrelationshiptype.id;

CREATE TABLE hat.people_person (
  id           INTEGER     NOT NULL DEFAULT nextval('hat.entity_id_seq'),
  date_created TIMESTAMP   NOT NULL,
  last_updated TIMESTAMP   NOT NULL,
  name         VARCHAR     NOT NULL,
  person_id    VARCHAR(36) NOT NULL,
  CONSTRAINT people_person_pkey PRIMARY KEY (id)
);

CREATE SEQUENCE hat.things_thingpersoncrossref_id_seq;

CREATE TABLE hat.things_thingpersoncrossref (
  id                    INTEGER      NOT NULL DEFAULT nextval('hat.things_thingpersoncrossref_id_seq'),
  date_created          TIMESTAMP    NOT NULL,
  last_updated          TIMESTAMP    NOT NULL,
  person_id             INTEGER      NOT NULL,
  thing_id              INTEGER      NOT NULL,
  relationship_type     VARCHAR(100) NOT NULL,
  is_current            BOOLEAN      NOT NULL,
  relationshiprecord_id INTEGER      NOT NULL,
  CONSTRAINT things_thingpersoncrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.things_thingpersoncrossref_id_seq OWNED BY hat.things_thingpersoncrossref.id;

CREATE INDEX things_thingpersoncrossref_owner_id
ON hat.things_thingpersoncrossref USING BTREE
(person_id);

CREATE INDEX things_thingpersoncrossref_thing_id
ON hat.things_thingpersoncrossref USING BTREE
(thing_id);

CREATE SEQUENCE hat.people_systemtypecrossref_id_seq;

CREATE TABLE hat.people_systemtypecrossref (
  id                INTEGER      NOT NULL DEFAULT nextval('hat.people_systemtypecrossref_id_seq'),
  date_created      TIMESTAMP    NOT NULL,
  last_updated      TIMESTAMP    NOT NULL,
  users_id          INTEGER      NOT NULL,
  system_type_id    INTEGER      NOT NULL,
  relationship_type VARCHAR(100) NOT NULL,
  is_current        BOOLEAN      NOT NULL,
  CONSTRAINT people_systemtypecrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.people_systemtypecrossref_id_seq OWNED BY hat.people_systemtypecrossref.id;

CREATE INDEX people_systemtypecrossref_person_id
ON hat.people_systemtypecrossref USING BTREE
(users_id);

CREATE SEQUENCE hat.people_persontopersoncrossref_id_seq;

CREATE TABLE hat.people_persontopersoncrossref (
  id                    INTEGER   NOT NULL DEFAULT nextval('hat.people_persontopersoncrossref_id_seq'),
  date_created          TIMESTAMP NOT NULL,
  last_updated          TIMESTAMP NOT NULL,
  person_one_id         INTEGER   NOT NULL,
  person_two_id         INTEGER   NOT NULL,
  relationship_type_id  INTEGER   NOT NULL,
  is_current            BOOLEAN   NOT NULL,
  relationshiprecord_id INTEGER   NOT NULL,
  CONSTRAINT people_persontopersoncrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.people_persontopersoncrossref_id_seq OWNED BY hat.people_persontopersoncrossref.id;

CREATE INDEX users_persontopersoncrossref_person_one_id
ON hat.people_persontopersoncrossref USING BTREE
(person_one_id);

CREATE INDEX users_persontopersoncrossref_person_two_id
ON hat.people_persontopersoncrossref USING BTREE
(person_two_id);

CREATE TABLE hat.organisations_organisation (
  id            INTEGER      NOT NULL DEFAULT nextval('hat.entity_id_seq'),
  date_created  TIMESTAMP    NOT NULL,
  lasty_updated TIMESTAMP    NOT NULL,
  name          VARCHAR(100) NOT NULL,
  CONSTRAINT organisations_organisation_pkey PRIMARY KEY (id)
);

CREATE SEQUENCE hat.people_personorganisationcrossref_id_seq;

CREATE TABLE hat.people_personorganisationcrossref (
  id                    INTEGER      NOT NULL DEFAULT nextval('hat.people_personorganisationcrossref_id_seq'),
  date_created          TIMESTAMP    NOT NULL,
  last_updated          TIMESTAMP    NOT NULL,
  organisation_id       INTEGER      NOT NULL,
  person_id             INTEGER      NOT NULL,
  relationship_type     VARCHAR(100) NOT NULL,
  is_current            BOOLEAN      NOT NULL,
  relationshiprecord_id INTEGER      NOT NULL,
  CONSTRAINT people_personorganisationcrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.people_personorganisationcrossref_id_seq OWNED BY hat.people_personorganisationcrossref.id;

CREATE INDEX people_personorganisationcrossref_organisation_id
ON hat.people_personorganisationcrossref USING BTREE
(organisation_id);

CREATE INDEX people_personorganisationcrossref_person_id
ON hat.people_personorganisationcrossref USING BTREE
(person_id);

CREATE SEQUENCE hat.organisations_systemtypecrossref_id_seq;

CREATE TABLE hat.organisations_systemtypecrossref (
  id                INTEGER      NOT NULL DEFAULT nextval('hat.organisations_systemtypecrossref_id_seq'),
  date_created      TIMESTAMP    NOT NULL,
  last_updated      TIMESTAMP    NOT NULL,
  organisation_id   INTEGER      NOT NULL,
  system_type_id    INTEGER      NOT NULL,
  relationship_type VARCHAR(100) NOT NULL,
  is_current        BOOLEAN      NOT NULL,
  CONSTRAINT organisations_systemtypecrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.organisations_systemtypecrossref_id_seq OWNED BY hat.organisations_systemtypecrossref.id;

CREATE INDEX organisations_systemtypecrossref_organisation_id
ON hat.organisations_systemtypecrossref USING BTREE
(organisation_id);

CREATE INDEX organisations_systemtypecrossref_system_type_id
ON hat.organisations_systemtypecrossref USING BTREE
(system_type_id);

CREATE SEQUENCE hat.organisations_organisationtoorganisationcrossref_id_seq;

CREATE TABLE hat.organisations_organisationtoorganisationcrossref (
  id                    INTEGER      NOT NULL DEFAULT nextval(
      'hat.organisations_organisationtoorganisationcrossref_id_seq'),
  date_created          TIMESTAMP    NOT NULL,
  last_updated          TIMESTAMP    NOT NULL,
  organisation_one_id   INTEGER      NOT NULL,
  organisation_two_id   INTEGER      NOT NULL,
  relationship_type     VARCHAR(100) NOT NULL,
  is_current            BOOLEAN      NOT NULL,
  relationshiprecord_id INTEGER      NOT NULL,
  CONSTRAINT organisations_organisationtoorganisationcrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.organisations_organisationtoorganisationcrossref_id_seq OWNED BY hat.organisations_organisationtoorganisationcrossref.id;

CREATE INDEX organisation_organisationtoorganisationcrossref_person_one_id
ON hat.organisations_organisationtoorganisationcrossref USING BTREE
(organisation_one_id);

CREATE INDEX organisation_organisationtoorganisationcrossref_person_two_id
ON hat.organisations_organisationtoorganisationcrossref USING BTREE
(organisation_two_id);

CREATE SEQUENCE hat.organisations_organisationthingcrossref_id_seq;

CREATE TABLE hat.organisations_organisationthingcrossref (
  id                    INTEGER      NOT NULL DEFAULT nextval('hat.organisations_organisationthingcrossref_id_seq'),
  date_created          TIMESTAMP    NOT NULL,
  last_updated          TIMESTAMP    NOT NULL,
  thing_id              INTEGER      NOT NULL,
  organisation_id       INTEGER      NOT NULL,
  relationship_type     VARCHAR(100) NOT NULL,
  is_current            BOOLEAN      NOT NULL,
  relationshiprecord_id INTEGER      NOT NULL,
  CONSTRAINT organisations_organisationthingcrossref_pk PRIMARY KEY (id)
);


ALTER SEQUENCE hat.organisations_organisationthingcrossref_id_seq OWNED BY hat.organisations_organisationthingcrossref.id;

CREATE TABLE hat.locations_location (
  id           INTEGER      NOT NULL DEFAULT nextval('hat.entity_id_seq'),
  date_created TIMESTAMP    NOT NULL,
  last_updated TIMESTAMP    NOT NULL,
  name         VARCHAR(512) NOT NULL,
  CONSTRAINT locations_location_pkey PRIMARY KEY (id)
);

CREATE SEQUENCE hat.people_personlocationcrossref_id_seq;

CREATE TABLE hat.people_personlocationcrossref (
  id                    INTEGER      NOT NULL DEFAULT nextval('hat.people_personlocationcrossref_id_seq'),
  date_created          TIMESTAMP    NOT NULL,
  last_updated          TIMESTAMP    NOT NULL,
  location_id           INTEGER      NOT NULL,
  person_id             INTEGER      NOT NULL,
  relationship_type     VARCHAR(100) NOT NULL,
  is_current            BOOLEAN      NOT NULL,
  relationshiprecord_id INTEGER      NOT NULL,
  CONSTRAINT people_personlocationcrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.people_personlocationcrossref_id_seq OWNED BY hat.people_personlocationcrossref.id;

CREATE INDEX locations_locationpersoncrossref_location_id
ON hat.people_personlocationcrossref USING BTREE
(location_id);

CREATE INDEX locations_locationpersoncrossref_person_id
ON hat.people_personlocationcrossref USING BTREE
(person_id);

CREATE SEQUENCE hat.organisations_organisationlocationcrossref_id_seq;

CREATE TABLE hat.organisations_organisationlocationcrossref (
  id                    INTEGER      NOT NULL DEFAULT nextval('hat.organisations_organisationlocationcrossref_id_seq'),
  date_created          TIMESTAMP    NOT NULL,
  last_updated          TIMESTAMP    NOT NULL,
  location_id           INTEGER      NOT NULL,
  organisation_id       INTEGER      NOT NULL,
  relationship_type     VARCHAR(100) NOT NULL,
  is_current            BOOLEAN      NOT NULL,
  relationshiprecord_id INTEGER      NOT NULL,
  CONSTRAINT organisations_organisationlocationcrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.organisations_organisationlocationcrossref_id_seq OWNED BY hat.organisations_organisationlocationcrossref.id;

CREATE INDEX organisations_organisationlocationcrossref_location_id
ON hat.organisations_organisationlocationcrossref USING BTREE
(location_id);

CREATE INDEX organisations_organisationlocationcrossref_organisation_id
ON hat.organisations_organisationlocationcrossref USING BTREE
(organisation_id);

CREATE SEQUENCE hat.locations_systemtypecrossref_id_seq;

CREATE TABLE hat.locations_systemtypecrossref (
  id                INTEGER      NOT NULL DEFAULT nextval('hat.locations_systemtypecrossref_id_seq'),
  date_created      TIMESTAMP    NOT NULL,
  last_updated      TIMESTAMP    NOT NULL,
  location_id       INTEGER      NOT NULL,
  system_type_id    INTEGER      NOT NULL,
  relationship_type VARCHAR(100) NOT NULL,
  is_current        BOOLEAN      NOT NULL,
  CONSTRAINT locations_systemtypecrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.locations_systemtypecrossref_id_seq OWNED BY hat.locations_systemtypecrossref.id;

CREATE INDEX location_systemtypecrossref_location_id
ON hat.locations_systemtypecrossref USING BTREE
(location_id);

CREATE INDEX location_systemtypecrossref_system_type_id
ON hat.locations_systemtypecrossref USING BTREE
(system_type_id);

CREATE SEQUENCE hat.locations_locationtolocationcrossref_id_seq;

CREATE TABLE hat.locations_locationtolocationcrossref (
  id                    INTEGER      NOT NULL DEFAULT nextval('hat.locations_locationtolocationcrossref_id_seq'),
  date_created          TIMESTAMP    NOT NULL,
  last_updated          TIMESTAMP    NOT NULL,
  loc_one_id            INTEGER      NOT NULL,
  loc_two_id            INTEGER      NOT NULL,
  relationship_type     VARCHAR(100) NOT NULL,
  is_current            BOOLEAN      NOT NULL,
  relationshiprecord_id INTEGER      NOT NULL,
  CONSTRAINT locations_locationtolocationcrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.locations_locationtolocationcrossref_id_seq OWNED BY hat.locations_locationtolocationcrossref.id;

CREATE INDEX locations_locationtolocationcrossref_loc_one_id
ON hat.locations_locationtolocationcrossref USING BTREE
(loc_one_id);

CREATE INDEX locations_locationtolocationcrossref_loc_two_id
ON hat.locations_locationtolocationcrossref USING BTREE
(loc_two_id);

CREATE SEQUENCE hat.locations_locationthingcrossref_id_seq;

CREATE TABLE hat.locations_locationthingcrossref (
  id                    INTEGER      NOT NULL DEFAULT nextval('hat.locations_locationthingcrossref_id_seq'),
  date_created          TIMESTAMP    NOT NULL,
  last_updated          TIMESTAMP    NOT NULL,
  thing_id              INTEGER      NOT NULL,
  location_id           INTEGER      NOT NULL,
  relationship_type     VARCHAR(100) NOT NULL,
  is_current            BOOLEAN      NOT NULL,
  relationshiprecord_id INTEGER      NOT NULL,
  CONSTRAINT locations_locationthingcrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.locations_locationthingcrossref_id_seq OWNED BY hat.locations_locationthingcrossref.id;

CREATE INDEX locations_locationthingcrossref_location_id
ON hat.locations_locationthingcrossref USING BTREE
(location_id);

CREATE INDEX locations_locationthingcrossref_thing_id
ON hat.locations_locationthingcrossref USING BTREE
(thing_id);

CREATE SEQUENCE hat.events_event_id_seq;

CREATE TABLE hat.events_event (
  id           INTEGER      NOT NULL DEFAULT nextval('hat.events_event_id_seq'),
  date_created TIMESTAMP    NOT NULL,
  last_updated TIMESTAMP    NOT NULL,
  name         VARCHAR(100) NOT NULL,
  CONSTRAINT events_event_pk PRIMARY KEY (id)
);


ALTER SEQUENCE hat.events_event_id_seq OWNED BY hat.events_event.id;

CREATE SEQUENCE hat.events_systemtypecrossref_id_seq;

CREATE TABLE hat.events_systemtypecrossref (
  id                INTEGER      NOT NULL DEFAULT nextval('hat.events_systemtypecrossref_id_seq'),
  date_created      TIMESTAMP    NOT NULL,
  last_updated      TIMESTAMP    NOT NULL,
  event_id          INTEGER      NOT NULL,
  system_type_id    INTEGER      NOT NULL,
  relationship_type VARCHAR(100) NOT NULL,
  is_current        BOOLEAN      NOT NULL,
  CONSTRAINT events_systemtypecrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.events_systemtypecrossref_id_seq OWNED BY hat.events_systemtypecrossref.id;

CREATE INDEX events_systemtypecrossref_system_type_id
ON hat.events_systemtypecrossref USING BTREE
(system_type_id);

CREATE INDEX events_systemtypecrossref_thing_id
ON hat.events_systemtypecrossref USING BTREE
(event_id);

CREATE SEQUENCE hat.events_eventtoeventcrossref_id_seq;

CREATE TABLE hat.events_eventtoeventcrossref (
  id                    INTEGER      NOT NULL DEFAULT nextval('hat.events_eventtoeventcrossref_id_seq'),
  date_created          TIMESTAMP    NOT NULL,
  last_updated          TIMESTAMP    NOT NULL,
  event_one_id          INTEGER      NOT NULL,
  event_two_id          INTEGER      NOT NULL,
  relationship_type     VARCHAR(100) NOT NULL,
  is_current            BOOLEAN      NOT NULL,
  relationshiprecord_id INTEGER      NOT NULL,
  CONSTRAINT events_eventtoeventcrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.events_eventtoeventcrossref_id_seq OWNED BY hat.events_eventtoeventcrossref.id;

CREATE INDEX events_eventtoeventcrossref_event_one_id
ON hat.events_eventtoeventcrossref USING BTREE
(event_one_id);

CREATE INDEX events_eventtoeventcrossref_event_two_id
ON hat.events_eventtoeventcrossref USING BTREE
(event_two_id);

CREATE SEQUENCE hat.events_eventthingcrossref_id_seq;

CREATE TABLE hat.events_eventthingcrossref (
  id                    INTEGER      NOT NULL DEFAULT nextval('hat.events_eventthingcrossref_id_seq'),
  date_created          TIMESTAMP    NOT NULL,
  last_updated          TIMESTAMP    NOT NULL,
  thing_id              INTEGER      NOT NULL,
  event_id              INTEGER      NOT NULL,
  relationship_type     VARCHAR(100) NOT NULL,
  is_current            BOOLEAN      NOT NULL,
  relationshiprecord_id INTEGER      NOT NULL,
  CONSTRAINT events_eventthingcrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.events_eventthingcrossref_id_seq OWNED BY hat.events_eventthingcrossref.id;

CREATE INDEX events_eventthing_eventid_crossref_owner_id
ON hat.events_eventthingcrossref USING BTREE
(event_id);

CREATE INDEX events_eventthing_thingid_crossref_owner_id
ON hat.events_eventthingcrossref USING BTREE
(thing_id);

CREATE SEQUENCE hat.events_eventpersoncrossref_id_seq;

CREATE TABLE hat.events_eventpersoncrossref (
  id                    INTEGER      NOT NULL DEFAULT nextval('hat.events_eventpersoncrossref_id_seq'),
  date_created          TIMESTAMP    NOT NULL,
  last_updated          TIMESTAMP    NOT NULL,
  person_id             INTEGER      NOT NULL,
  event_id              INTEGER      NOT NULL,
  relationship_type     VARCHAR(100) NOT NULL,
  is_current            BOOLEAN      NOT NULL,
  relationshiprecord_id INTEGER      NOT NULL,
  CONSTRAINT events_eventpersoncrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.events_eventpersoncrossref_id_seq OWNED BY hat.events_eventpersoncrossref.id;

CREATE INDEX events_eventpersoncrossref_event_id
ON hat.events_eventpersoncrossref USING BTREE
(event_id);

CREATE INDEX events_eventpersoncrossref_person_id
ON hat.events_eventpersoncrossref USING BTREE
(person_id);

CREATE SEQUENCE hat.events_eventorganisationcrossref_id_seq;

CREATE TABLE hat.events_eventorganisationcrossref (
  id                    INTEGER      NOT NULL DEFAULT nextval('hat.events_eventorganisationcrossref_id_seq'),
  date_created          TIMESTAMP    NOT NULL,
  last_updated          TIMESTAMP    NOT NULL,
  organisation_id       INTEGER      NOT NULL,
  event_id              INTEGER      NOT NULL,
  relationship_type     VARCHAR(100) NOT NULL,
  is_current            BOOLEAN      NOT NULL,
  relationshiprecord_id INTEGER      NOT NULL,
  CONSTRAINT events_eventorganisationcrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.events_eventorganisationcrossref_id_seq OWNED BY hat.events_eventorganisationcrossref.id;

CREATE INDEX events_eventorganisationcrossref_event_id
ON hat.events_eventorganisationcrossref USING BTREE
(event_id);

CREATE INDEX events_eventorganisationcrossref_organisation_id
ON hat.events_eventorganisationcrossref USING BTREE
(organisation_id);

CREATE SEQUENCE hat.events_eventlocationcrossref_id_seq;

CREATE TABLE hat.events_eventlocationcrossref (
  id                    INTEGER      NOT NULL DEFAULT nextval('hat.events_eventlocationcrossref_id_seq'),
  date_created          TIMESTAMP    NOT NULL,
  last_updated          TIMESTAMP    NOT NULL,
  location_id           INTEGER      NOT NULL,
  event_id              INTEGER      NOT NULL,
  relationship_type     VARCHAR(100) NOT NULL,
  is_current            BOOLEAN      NOT NULL,
  relationshiprecord_id INTEGER      NOT NULL,
  CONSTRAINT events_eventlocationcrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.events_eventlocationcrossref_id_seq OWNED BY hat.events_eventlocationcrossref.id;

CREATE INDEX events_eventlocationcrossref_event_id
ON hat.events_eventlocationcrossref USING BTREE
(event_id);

CREATE INDEX events_eventlocationcrossref_location_id
ON hat.events_eventlocationcrossref USING BTREE
(location_id);

CREATE TABLE hat.entity (
  id              INTEGER      NOT NULL,
  date_created    TIMESTAMP    NOT NULL,
  last_updated    TIMESTAMP    NOT NULL,
  name            VARCHAR(100) NOT NULL,
  kind            VARCHAR(100) NOT NULL,
  location_id     INTEGER,
  thing_id        INTEGER,
  event_id        INTEGER,
  organisation_id INTEGER,
  person_id       INTEGER,
  CONSTRAINT kind CHECK
  (CASE WHEN location_id IS NULL AND NOT kind = 'location'
    THEN 0
   ELSE 1 END +
   CASE WHEN thing_id IS NULL AND NOT kind = 'thing'
     THEN 0
   ELSE 1 END +
   CASE WHEN event_id IS NULL AND NOT kind = 'event'
     THEN 0
   ELSE 1 END +
   CASE WHEN organisation_id IS NULL AND NOT kind = 'organisation'
     THEN 0
   ELSE 1 END +
   CASE WHEN person_id IS NULL AND NOT kind = 'person'
     THEN 0
   ELSE 1 END = 1),
  CONSTRAINT entity_pk PRIMARY KEY (id)
);

ALTER SEQUENCE hat.entity_id_seq OWNED BY hat.entity.id;

CREATE SEQUENCE hat.data_table_id_seq;

CREATE TABLE hat.data_table (
  id           INTEGER   NOT NULL DEFAULT nextval('hat.data_table_id_seq'),
  date_created TIMESTAMP NOT NULL,
  last_updated TIMESTAMP NOT NULL,
  name         VARCHAR   NOT NULL,
  source_name  VARCHAR   NOT NULL,
  CONSTRAINT data_table_pk PRIMARY KEY (id),
  CONSTRAINT data_table_name_source UNIQUE (name, source_name)
);


ALTER SEQUENCE hat.data_table_id_seq OWNED BY hat.data_table.id;

CREATE SEQUENCE hat.data_tabletotablecrossref_id_seq;

CREATE TABLE hat.data_tabletotablecrossref (
  id                INTEGER   NOT NULL DEFAULT nextval('hat.data_tabletotablecrossref_id_seq'),
  date_created      TIMESTAMP NOT NULL,
  last_updated      TIMESTAMP NOT NULL,
  relationship_type VARCHAR   NOT NULL,
  table1            INTEGER   NOT NULL,
  table2            INTEGER   NOT NULL,
  CONSTRAINT data_tabletotablecrossref_pk PRIMARY KEY (id)
);


ALTER SEQUENCE hat.data_tabletotablecrossref_id_seq OWNED BY hat.data_tabletotablecrossref.id;

CREATE SEQUENCE hat.data_record_id_seq;

CREATE TABLE hat.data_record (
  id           INTEGER   NOT NULL DEFAULT nextval('hat.data_record_id_seq'),
  date_created TIMESTAMP NOT NULL,
  last_updated TIMESTAMP NOT NULL,
  name         VARCHAR   NOT NULL,
  CONSTRAINT data_record_pk PRIMARY KEY (id)
);


ALTER SEQUENCE hat.data_record_id_seq OWNED BY hat.data_record.id;

CREATE SEQUENCE hat.data_field_id_seq;

CREATE TABLE hat.data_field (
  id           INTEGER   NOT NULL DEFAULT nextval('hat.data_field_id_seq'),
  date_created TIMESTAMP NOT NULL,
  last_updated TIMESTAMP NOT NULL,
  name         VARCHAR   NOT NULL,
  table_id_fk  INTEGER   NOT NULL,
  CONSTRAINT data_field_pk PRIMARY KEY (id)
);


ALTER SEQUENCE hat.data_field_id_seq OWNED BY hat.data_field.id;

CREATE SEQUENCE hat.things_systempropertystaticcrossref_id_seq;

CREATE TABLE hat.things_systempropertystaticcrossref (
  id                 INTEGER      NOT NULL DEFAULT nextval('hat.things_systempropertystaticcrossref_id_seq'),
  date_created       TIMESTAMP    NOT NULL,
  last_updated       TIMESTAMP    NOT NULL,
  thing_id           INTEGER      NOT NULL,
  system_property_id INTEGER      NOT NULL,
  record_id          INTEGER      NOT NULL,
  field_id           INTEGER      NOT NULL,
  relationship_type  VARCHAR(100) NOT NULL,
  is_current         BOOLEAN      NOT NULL,
  propertyrecord_id  INTEGER      NOT NULL,
  CONSTRAINT things_systempropertystaticcrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.things_systempropertystaticcrossref_id_seq OWNED BY hat.things_systempropertystaticcrossref.id;

CREATE INDEX things_thingstaticpropertycrossref_thing_id
ON hat.things_systempropertystaticcrossref USING BTREE
(thing_id);

CREATE INDEX things_thingstaticpropertycrossref_thing_property_id
ON hat.things_systempropertystaticcrossref USING BTREE
(system_property_id);

CREATE SEQUENCE hat.things_systempropertydynamiccrossref_id_seq;

CREATE TABLE hat.things_systempropertydynamiccrossref (
  id                 INTEGER      NOT NULL DEFAULT nextval('hat.things_systempropertydynamiccrossref_id_seq'),
  date_created       TIMESTAMP    NOT NULL,
  last_updated       TIMESTAMP    NOT NULL,
  thing_id           INTEGER      NOT NULL,
  system_property_id INTEGER      NOT NULL,
  field_id           INTEGER      NOT NULL,
  relationship_type  VARCHAR(100) NOT NULL,
  is_current         BOOLEAN      NOT NULL,
  propertyrecord_id  INTEGER      NOT NULL,
  CONSTRAINT things_systempropertydynamiccrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.things_systempropertydynamiccrossref_id_seq OWNED BY hat.things_systempropertydynamiccrossref.id;

CREATE INDEX things_thingdyanmicpropertycrossref_thing_property_id
ON hat.things_systempropertydynamiccrossref USING BTREE
(system_property_id);

CREATE INDEX things_thingdynamicpropertycrossref_thing_id
ON hat.things_systempropertydynamiccrossref USING BTREE
(thing_id);

CREATE SEQUENCE hat.people_systempropertystaticcrossref_id_seq;

CREATE TABLE hat.people_systempropertystaticcrossref (
  id                 INTEGER      NOT NULL DEFAULT nextval('hat.people_systempropertystaticcrossref_id_seq'),
  date_created       TIMESTAMP    NOT NULL,
  last_updated       TIMESTAMP    NOT NULL,
  person_id          INTEGER      NOT NULL,
  system_property_id INTEGER      NOT NULL,
  record_id          INTEGER      NOT NULL,
  field_id           INTEGER      NOT NULL,
  relationship_type  VARCHAR(100) NOT NULL,
  is_current         BOOLEAN      NOT NULL,
  propertyrecord_id  INTEGER      NOT NULL,
  CONSTRAINT people_systempropertystaticcrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.people_systempropertystaticcrossref_id_seq OWNED BY hat.people_systempropertystaticcrossref.id;

CREATE INDEX people_systempropertystaticcrossref_person_id
ON hat.people_systempropertystaticcrossref USING BTREE
(person_id);

CREATE INDEX people_systempropertystaticcrossref_property_id
ON hat.people_systempropertystaticcrossref USING BTREE
(system_property_id);

CREATE SEQUENCE hat.people_systempropertydynamiccrossref_id_seq;

CREATE TABLE hat.people_systempropertydynamiccrossref (
  id                 INTEGER      NOT NULL DEFAULT nextval('hat.people_systempropertydynamiccrossref_id_seq'),
  date_created       TIMESTAMP    NOT NULL,
  last_updated       TIMESTAMP    NOT NULL,
  person_id          INTEGER      NOT NULL,
  system_property_id INTEGER      NOT NULL,
  field_id           INTEGER      NOT NULL,
  relationship_type  VARCHAR(100) NOT NULL,
  is_current         BOOLEAN      NOT NULL,
  propertyrecord_id  INTEGER      NOT NULL,
  CONSTRAINT people_systempropertydynamiccrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.people_systempropertydynamiccrossref_id_seq OWNED BY hat.people_systempropertydynamiccrossref.id;

CREATE INDEX people_systempropertydynamiccrossref_people_id
ON hat.people_systempropertydynamiccrossref USING BTREE
(person_id);

CREATE INDEX people_systempropertydynamiccrossref_property_id
ON hat.people_systempropertydynamiccrossref USING BTREE
(system_property_id);

CREATE SEQUENCE hat.organisations_systempropertystaticcrossref_id_seq;

CREATE TABLE hat.organisations_systempropertystaticcrossref (
  id                 INTEGER      NOT NULL DEFAULT nextval('hat.organisations_systempropertystaticcrossref_id_seq'),
  date_created       TIMESTAMP    NOT NULL,
  last_updated       TIMESTAMP    NOT NULL,
  organisation_id    INTEGER      NOT NULL,
  system_property_id INTEGER      NOT NULL,
  record_id          INTEGER      NOT NULL,
  field_id           INTEGER      NOT NULL,
  relationship_type  VARCHAR(100) NOT NULL,
  is_current         BOOLEAN      NOT NULL,
  propertyrecord_id  INTEGER      NOT NULL,
  CONSTRAINT organisations_systempropertystaticcrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.organisations_systempropertystaticcrossref_id_seq OWNED BY hat.organisations_systempropertystaticcrossref.id;

CREATE INDEX organisationssystempropertystaticcrossref_organisation_id
ON hat.organisations_systempropertystaticcrossref USING BTREE
(organisation_id);

CREATE INDEX organisationssystempropertystaticcrossref_property_id
ON hat.organisations_systempropertystaticcrossref USING BTREE
(system_property_id);

CREATE SEQUENCE hat.organisations_systempropertydynamiccrossref_id_seq;

CREATE TABLE hat.organisations_systempropertydynamiccrossref (
  id                 INTEGER      NOT NULL DEFAULT nextval('hat.organisations_systempropertydynamiccrossref_id_seq'),
  date_created       TIMESTAMP    NOT NULL,
  last_updated       TIMESTAMP    NOT NULL,
  organisation_id    INTEGER      NOT NULL,
  system_property_id INTEGER      NOT NULL,
  field_id           INTEGER      NOT NULL,
  relationship_type  VARCHAR(100) NOT NULL,
  is_current         BOOLEAN      NOT NULL,
  propertyrecord_id  INTEGER      NOT NULL,
  CONSTRAINT organisations_systempropertydynamiccrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.organisations_systempropertydynamiccrossref_id_seq OWNED BY hat.organisations_systempropertydynamiccrossref.id;

CREATE INDEX organisationssystempropertydynamiccrossref_organisation_id
ON hat.organisations_systempropertydynamiccrossref USING BTREE
(organisation_id);

CREATE INDEX organisationssystempropertydynamiccrossref_property_id
ON hat.organisations_systempropertydynamiccrossref USING BTREE
(system_property_id);

CREATE SEQUENCE hat.locations_systempropertystaticcrossref_id_seq;

CREATE TABLE hat.locations_systempropertystaticcrossref (
  id                 INTEGER      NOT NULL DEFAULT nextval('hat.locations_systempropertystaticcrossref_id_seq'),
  date_created       TIMESTAMP    NOT NULL,
  last_updated       TIMESTAMP    NOT NULL,
  location_id        INTEGER      NOT NULL,
  system_property_id INTEGER      NOT NULL,
  record_id          INTEGER      NOT NULL,
  field_id           INTEGER      NOT NULL,
  relationship_type  VARCHAR(100) NOT NULL,
  is_current         BOOLEAN      NOT NULL,
  propertyrecord_id  INTEGER      NOT NULL,
  CONSTRAINT locations_systempropertystaticcrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.locations_systempropertystaticcrossref_id_seq OWNED BY hat.locations_systempropertystaticcrossref.id;

CREATE INDEX locations_systempropertystaticcrossref_location_id
ON hat.locations_systempropertystaticcrossref USING BTREE
(location_id);

CREATE INDEX locations_systempropertystaticcrossref_property_id
ON hat.locations_systempropertystaticcrossref USING BTREE
(system_property_id);

CREATE SEQUENCE hat.locations_systempropertydynamiccrossref_id_seq;

CREATE TABLE hat.locations_systempropertydynamiccrossref (
  id                 INTEGER      NOT NULL DEFAULT nextval('hat.locations_systempropertydynamiccrossref_id_seq'),
  date_created       TIMESTAMP    NOT NULL,
  last_updated       TIMESTAMP    NOT NULL,
  location_id        INTEGER      NOT NULL,
  system_property_id INTEGER      NOT NULL,
  field_id           INTEGER      NOT NULL,
  relationship_type  VARCHAR(100) NOT NULL,
  is_current         BOOLEAN      NOT NULL,
  propertyrecord_id  INTEGER      NOT NULL,
  CONSTRAINT locations_systempropertydynamiccrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.locations_systempropertydynamiccrossref_id_seq OWNED BY hat.locations_systempropertydynamiccrossref.id;

CREATE INDEX locations_systempropertydynamiccrossref_location_id
ON hat.locations_systempropertydynamiccrossref USING BTREE
(location_id);

CREATE INDEX locations_systempropertydynamiccrossref_property_id
ON hat.locations_systempropertydynamiccrossref USING BTREE
(system_property_id);

CREATE SEQUENCE hat.events_systempropertystaticcrossref_id_seq;

CREATE TABLE hat.events_systempropertystaticcrossref (
  id                 INTEGER      NOT NULL DEFAULT nextval('hat.events_systempropertystaticcrossref_id_seq'),
  date_created       TIMESTAMP    NOT NULL,
  last_updated       TIMESTAMP    NOT NULL,
  event_id           INTEGER      NOT NULL,
  system_property_id INTEGER      NOT NULL,
  record_id          INTEGER      NOT NULL,
  field_id           INTEGER      NOT NULL,
  relationship_type  VARCHAR(100) NOT NULL,
  is_current         BOOLEAN      NOT NULL,
  propertyrecord_id  INTEGER      NOT NULL,
  CONSTRAINT events_systempropertystaticcrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.events_systempropertystaticcrossref_id_seq OWNED BY hat.events_systempropertystaticcrossref.id;

CREATE INDEX events_systempropertystaticcrossref_event_id
ON hat.events_systempropertystaticcrossref USING BTREE
(event_id);

CREATE SEQUENCE hat.events_systempropertydynamiccrossref_id_seq;

CREATE TABLE hat.events_systempropertydynamiccrossref (
  id                 INTEGER      NOT NULL DEFAULT nextval('hat.events_systempropertydynamiccrossref_id_seq'),
  date_created       TIMESTAMP    NOT NULL,
  last_updated       TIMESTAMP    NOT NULL,
  event_id           INTEGER      NOT NULL,
  system_property_id INTEGER      NOT NULL,
  field_id           INTEGER      NOT NULL,
  relationship_type  VARCHAR(100) NOT NULL,
  is_current         BOOLEAN      NOT NULL,
  propertyrecord_id  INTEGER      NOT NULL,
  CONSTRAINT events_systempropertydynamiccrossref_pkey PRIMARY KEY (id)
);


ALTER SEQUENCE hat.events_systempropertydynamiccrossref_id_seq OWNED BY hat.events_systempropertydynamiccrossref.id;

CREATE INDEX events_systempropertydynamiccrossref_event_id
ON hat.events_systempropertydynamiccrossref USING BTREE
(event_id);

CREATE INDEX events_systempropertydynamiccrossref_property_id
ON hat.events_systempropertydynamiccrossref USING BTREE
(system_property_id);

CREATE SEQUENCE hat.data_value_id_seq;

CREATE TABLE hat.data_value (
  id           INTEGER   NOT NULL DEFAULT nextval('hat.data_value_id_seq'),
  date_created TIMESTAMP NOT NULL,
  last_updated TIMESTAMP NOT NULL,
  value        TEXT      NOT NULL,
  field_id     INTEGER   NOT NULL,
  record_id    INTEGER   NOT NULL,
  CONSTRAINT data_value_pk PRIMARY KEY (id)
);


ALTER SEQUENCE hat.data_value_id_seq OWNED BY hat.data_value.id;

CREATE SEQUENCE hat.data_debit_id_seq;

CREATE TABLE hat.data_debit (
  data_debit_key        UUID      NOT NULL,
  date_created          TIMESTAMP NOT NULL,
  last_updated          TIMESTAMP NOT NULL,
  name                  VARCHAR   NOT NULL,
  start_date            TIMESTAMP NOT NULL,
  end_date              TIMESTAMP NOT NULL,
  rolling               BOOLEAN   NOT NULL,
  sell_rent             BOOLEAN   NOT NULL,
  price                 REAL      NOT NULL,
  enabled               BOOLEAN   NOT NULL,
  sender_id             VARCHAR   NOT NULL,
  recipient_id          VARCHAR   NOT NULL,
  bundle_contextless_id INTEGER,
  bundle_context_id     INTEGER,
  kind                  VARCHAR   NOT NULL,
  CONSTRAINT data_debit_pk PRIMARY KEY (data_debit_key),
  CONSTRAINT kind CHECK
  (CASE WHEN bundle_contextless_id IS NULL AND NOT kind = 'contextless'
    THEN 0
   ELSE 1 END +
   CASE WHEN bundle_context_id IS NULL AND NOT kind = 'contextual'
     THEN 0
   ELSE 1 END = 1)
);

CREATE SEQUENCE hat.bundle_contextless_table_id_seq;

CREATE TABLE hat.bundle_contextless_table (
  id           INTEGER   NOT NULL DEFAULT nextval('hat.bundle_contextless_table_id_seq'),
  last_updated TIMESTAMP NOT NULL,
  date_created TIMESTAMP NOT NULL,
  name         VARCHAR   NOT NULL,
  data_table   INTEGER   NOT NULL,
  CONSTRAINT bundle_contextless_table_pk PRIMARY KEY (id)
);


ALTER SEQUENCE hat.bundle_contextless_table_id_seq OWNED BY hat.bundle_contextless_table.id;

CREATE SEQUENCE hat.bundle_contextless_table_slice_id_seq;

CREATE TABLE hat.bundle_contextless_table_slice (
  id                          INTEGER   NOT NULL DEFAULT nextval('hat.bundle_contextless_table_slice_id_seq'),
  date_created                TIMESTAMP NOT NULL,
  last_updated                TIMESTAMP NOT NULL,
  bundle_contextless_table_id INTEGER   NOT NULL,
  data_table_id               INTEGER   NOT NULL,
  CONSTRAINT bundle_contextless_table_slice_pk PRIMARY KEY (id)
);


ALTER SEQUENCE hat.bundle_contextless_table_slice_id_seq OWNED BY hat.bundle_contextless_table_slice.id;

CREATE SEQUENCE hat.bundle_contextless_table_slice_condition_id_seq;

CREATE TABLE hat.bundle_contextless_table_slice_condition (
  id             INTEGER   NOT NULL DEFAULT nextval('hat.bundle_contextless_table_slice_condition_id_seq'),
  date_created   TIMESTAMP NOT NULL,
  last_updated   TIMESTAMP NOT NULL,
  field_id       INTEGER   NOT NULL,
  table_slice_id INTEGER   NOT NULL,
  operator       VARCHAR   NOT NULL,
  value          VARCHAR   NOT NULL,
  CONSTRAINT bundle_contextless_table_slice_condition_pk PRIMARY KEY (id)
);


ALTER SEQUENCE hat.bundle_contextless_table_slice_condition_id_seq OWNED BY hat.bundle_contextless_table_slice_condition.id;

CREATE SEQUENCE hat.bundle_contextless_id_seq;

CREATE TABLE hat.bundle_contextless (
  id           INTEGER   NOT NULL DEFAULT nextval('hat.bundle_contextless_id_seq'),
  name         VARCHAR   NOT NULL,
  date_created TIMESTAMP NOT NULL,
  last_updated TIMESTAMP NOT NULL,
  CONSTRAINT bundle_contextless_bundle_pk PRIMARY KEY (id)
);


ALTER SEQUENCE hat.bundle_contextless_id_seq OWNED BY hat.bundle_contextless.id;

CREATE SEQUENCE hat.bundle_contextless_join_id_seq;

CREATE TABLE hat.bundle_contextless_join (
  id                             INTEGER   NOT NULL DEFAULT nextval('hat.bundle_contextless_join_id_seq'),
  date_created                   TIMESTAMP NOT NULL,
  last_updated                   TIMESTAMP NOT NULL,
  name                           VARCHAR   NOT NULL,
  bundle_contextless_table_id    INTEGER   NOT NULL,
  bundle_contextless_id          INTEGER   NOT NULL,
  bundle_contextless_join_field  INTEGER,
  bundle_contextless_table_field INTEGER,
  operator                       VARCHAR,
  CONSTRAINT bundle_contextless_join_pk PRIMARY KEY (id)
);


ALTER SEQUENCE hat.bundle_contextless_join_id_seq OWNED BY hat.bundle_contextless_join.id;

CREATE SEQUENCE hat.bundle_context_id_seq;

CREATE TABLE hat.bundle_context (
  id           INTEGER   NOT NULL DEFAULT nextval('hat.bundle_context_id_seq'),
  date_created TIMESTAMP NOT NULL,
  last_updated TIMESTAMP NOT NULL,
  name         VARCHAR   NOT NULL,
  CONSTRAINT bundle_context_bundle_pk PRIMARY KEY (id)
);


ALTER SEQUENCE hat.bundle_context_id_seq OWNED BY hat.bundle_context.id;

CREATE SEQUENCE hat.bundle_context_to_bundle_crossref_seq;

CREATE TABLE hat.bundle_context_to_bundle_crossref (
  id            INTEGER   NOT NULL DEFAULT nextval('hat.bundle_context_to_bundle_crossref_seq'),
  date_created  TIMESTAMP NOT NULL,
  last_updated  TIMESTAMP NOT NULL,
  bundle_parent INTEGER   NOT NULL,
  bundle_child  INTEGER   NOT NULL,
  CONSTRAINT bundle_context_to_bundle_crossref_pk PRIMARY KEY (id)
);

ALTER SEQUENCE hat.bundle_context_to_bundle_crossref_seq OWNED BY hat.bundle_context_to_bundle_crossref.id;

CREATE SEQUENCE hat.bundle_context_entity_selection_id_seq;

CREATE TABLE hat.bundle_context_entity_selection (
  id                INTEGER   NOT NULL DEFAULT nextval('hat.bundle_context_entity_selection_id_seq'),
  bundle_context_id INT       NOT NULL,
  date_created      TIMESTAMP NOT NULL,
  last_updated      TIMESTAMP NOT NULL,
  entity_name       VARCHAR(100),
  entity_id         INTEGER,
  entity_kind       VARCHAR(100),
  CONSTRAINT entity_selection_pkey PRIMARY KEY (id)
);

ALTER SEQUENCE hat.bundle_context_entity_selection_id_seq OWNED BY hat.bundle_context_entity_selection.id;


ALTER TABLE hat.bundle_context_entity_selection
  ADD CONSTRAINT entity_selection_bundle_context_fk
FOREIGN KEY (bundle_context_id)
REFERENCES hat.bundle_context (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


CREATE SEQUENCE hat.bundle_context_property_selection_id_seq;

CREATE TABLE hat.bundle_context_property_selection (
  property_selection_id              INTEGER   NOT NULL DEFAULT nextval('hat.bundle_context_property_selection_id_seq'),
  bundle_context_entity_selection_id INT       NOT NULL,
  date_created                       TIMESTAMP NOT NULL,
  last_updated                       TIMESTAMP NOT NULL,
  property_relationship_kind         VARCHAR(7),
  property_relationship_id           INT,
  property_name                      VARCHAR,
  property_type                      VARCHAR,
  property_unitofmeasurement         VARCHAR,
  CONSTRAINT property_seleciton_pkey PRIMARY KEY (property_selection_id)
);

ALTER SEQUENCE hat.bundle_context_property_selection_id_seq OWNED BY hat.bundle_context_property_selection.property_selection_id;


ALTER TABLE hat.bundle_context_property_selection
  ADD CONSTRAINT property_selection_entity_selection__fk
FOREIGN KEY (bundle_context_entity_selection_id)
REFERENCES hat.bundle_context_entity_selection (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- ----------------------------
--  Table structure for user_user
-- ----------------------------
CREATE TABLE hat.user_user (
  "user_id"      UUID         NOT NULL,
  "date_created" TIMESTAMP(6) NOT NULL,
  "last_updated" TIMESTAMP(6) NOT NULL,
  "email"        VARCHAR      NOT NULL,
  "pass"         VARCHAR,
  "name"         VARCHAR      NOT NULL,
  "role"         VARCHAR      NOT NULL,
  "enabled"      BOOL         NOT NULL DEFAULT FALSE
);

-- ----------------------------
--  Primary key structure for table user_user
-- ----------------------------
ALTER TABLE hat.user_user
  ADD PRIMARY KEY ("user_id") NOT DEFERRABLE INITIALLY IMMEDIATE;


CREATE TABLE hat.user_access_token (
  access_token VARCHAR NOT NULL,
  user_id      UUID    NOT NULL,
  CONSTRAINT access_token_pk PRIMARY KEY (access_token),
  CONSTRAINT user_fk FOREIGN KEY (user_id) REFERENCES hat.user_user (user_id)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
);

ALTER TABLE hat.entity
  ADD CONSTRAINT things_thing_entity_fk
FOREIGN KEY (thing_id)
REFERENCES hat.things_thing (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.events_eventthingcrossref
  ADD CONSTRAINT events_thingeventcrossref_fk
FOREIGN KEY (thing_id)
REFERENCES hat.things_thing (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.locations_locationthingcrossref
  ADD CONSTRAINT thing_id_refs_id_fk
FOREIGN KEY (thing_id)
REFERENCES hat.things_thing (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE hat.organisations_organisationthingcrossref
  ADD CONSTRAINT things_thing_organisations_organisationthingcrossref_fk
FOREIGN KEY (thing_id)
REFERENCES hat.things_thing (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.things_systempropertydynamiccrossref
  ADD CONSTRAINT things_systempropertydynamiccrossref_fk
FOREIGN KEY (thing_id)
REFERENCES hat.things_thing (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.things_systempropertystaticcrossref
  ADD CONSTRAINT things_thingstaticpropertycrossref_thing_id_fkey
FOREIGN KEY (thing_id)
REFERENCES hat.things_thing (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE hat.things_systemtypecrossref
  ADD CONSTRAINT things_systemtypecrossref_fk
FOREIGN KEY (thing_id)
REFERENCES hat.things_thing (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.things_thingpersoncrossref
  ADD CONSTRAINT things_thingpersoncrossref_thing_id_fkey
FOREIGN KEY (thing_id)
REFERENCES hat.things_thing (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE hat.things_thingtothingcrossref
  ADD CONSTRAINT thing_two_id_refs_id_fk
FOREIGN KEY (thing_two_id)
REFERENCES hat.things_thing (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE hat.things_thingtothingcrossref
  ADD CONSTRAINT thing_one_id_refs_id_fk
FOREIGN KEY (thing_one_id)
REFERENCES hat.things_thing (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE hat.system_property
  ADD CONSTRAINT system_unitofmeasurement_system_property_fk
FOREIGN KEY (unitofmeasurement_id)
REFERENCES hat.system_unitofmeasurement (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.events_systemtypecrossref
  ADD CONSTRAINT system_type_events_systemtypecrossref_fk
FOREIGN KEY (system_type_id)
REFERENCES hat.system_type (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.locations_systemtypecrossref
  ADD CONSTRAINT system_type_location_systemtypecrossref_fk
FOREIGN KEY (system_type_id)
REFERENCES hat.system_type (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.organisations_systemtypecrossref
  ADD CONSTRAINT system_type_organisations_systemtypecrossref_fk
FOREIGN KEY (system_type_id)
REFERENCES hat.system_type (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.people_systemtypecrossref
  ADD CONSTRAINT system_type_people_systemtypecrossref_fk
FOREIGN KEY (system_type_id)
REFERENCES hat.system_type (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.system_property
  ADD CONSTRAINT system_type_system_property_fk
FOREIGN KEY (type_id)
REFERENCES hat.system_type (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.system_typetotypecrossref
  ADD CONSTRAINT system_type_system_typetotypecrossref_fk1
FOREIGN KEY (type_two_id)
REFERENCES hat.system_type (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.system_typetotypecrossref
  ADD CONSTRAINT system_type_system_typetotypecrossref_fk
FOREIGN KEY (type_one_id)
REFERENCES hat.system_type (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.things_systemtypecrossref
  ADD CONSTRAINT system_type_things_systemtypecrossref_fk
FOREIGN KEY (system_type_id)
REFERENCES hat.system_type (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.events_eventlocationcrossref
  ADD CONSTRAINT system_relationshiprecord_events_eventlocationcrossref_fk
FOREIGN KEY (relationshiprecord_id)
REFERENCES hat.system_relationshiprecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.events_eventorganisationcrossref
  ADD CONSTRAINT system_relationshiprecord_events_eventorganisationcrossref_fk
FOREIGN KEY (relationshiprecord_id)
REFERENCES hat.system_relationshiprecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.events_eventpersoncrossref
  ADD CONSTRAINT system_relationshiprecord_events_eventpersoncrossref_fk
FOREIGN KEY (relationshiprecord_id)
REFERENCES hat.system_relationshiprecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.events_eventthingcrossref
  ADD CONSTRAINT system_relationshiprecord_events_eventthingcrossref_fk
FOREIGN KEY (relationshiprecord_id)
REFERENCES hat.system_relationshiprecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.events_eventtoeventcrossref
  ADD CONSTRAINT system_relationshiprecord_events_eventtoeventcrossref_fk
FOREIGN KEY (relationshiprecord_id)
REFERENCES hat.system_relationshiprecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.locations_locationthingcrossref
  ADD CONSTRAINT system_relationshiprecord_locations_locationthingcrossref_fk
FOREIGN KEY (relationshiprecord_id)
REFERENCES hat.system_relationshiprecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.locations_locationtolocationcrossref
  ADD CONSTRAINT system_relationshiprecord_locations_locationtolocationcrossr309
FOREIGN KEY (relationshiprecord_id)
REFERENCES hat.system_relationshiprecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.organisations_organisationlocationcrossref
  ADD CONSTRAINT system_relationshiprecord_organisations_organisationlocation278
FOREIGN KEY (relationshiprecord_id)
REFERENCES hat.system_relationshiprecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.organisations_organisationthingcrossref
  ADD CONSTRAINT system_relationshiprecord_organisations_organisationthingcro825
FOREIGN KEY (relationshiprecord_id)
REFERENCES hat.system_relationshiprecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.organisations_organisationtoorganisationcrossref
  ADD CONSTRAINT system_relationshiprecord_organisations_organisationtoorgani310
FOREIGN KEY (relationshiprecord_id)
REFERENCES hat.system_relationshiprecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.people_personlocationcrossref
  ADD CONSTRAINT system_relationshiprecord_people_personlocationcrossref_fk
FOREIGN KEY (relationshiprecord_id)
REFERENCES hat.system_relationshiprecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.people_personorganisationcrossref
  ADD CONSTRAINT system_relationshiprecord_people_personorganisationcrossref_fk
FOREIGN KEY (relationshiprecord_id)
REFERENCES hat.system_relationshiprecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.people_persontopersoncrossref
  ADD CONSTRAINT system_relationshiprecord_people_persontopersoncrossref_fk
FOREIGN KEY (relationshiprecord_id)
REFERENCES hat.system_relationshiprecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.system_relationshiprecordtorecordcrossref
  ADD CONSTRAINT system_relationshiprecord_system_relationshiprecordtorecordc567
FOREIGN KEY (relationshiprecord_id1)
REFERENCES hat.system_relationshiprecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.system_relationshiprecordtorecordcrossref
  ADD CONSTRAINT system_relationshiprecord_system_relationshiprecordtorecordc18
FOREIGN KEY (relationshiprecord_id2)
REFERENCES hat.system_relationshiprecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.things_thingpersoncrossref
  ADD CONSTRAINT system_relationshiprecord_things_thingpersoncrossref_fk
FOREIGN KEY (relationshiprecord_id)
REFERENCES hat.system_relationshiprecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.things_thingtothingcrossref
  ADD CONSTRAINT system_relationshiprecord_things_thingtothingcrossref_fk
FOREIGN KEY (relationshiprecord_id)
REFERENCES hat.system_relationshiprecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.events_systempropertydynamiccrossref
  ADD CONSTRAINT property_record_events_systempropertydynamiccrossref_fk
FOREIGN KEY (propertyrecord_id)
REFERENCES hat.system_propertyrecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.events_systempropertystaticcrossref
  ADD CONSTRAINT property_record_events_systempropertystaticcrossref_fk
FOREIGN KEY (propertyrecord_id)
REFERENCES hat.system_propertyrecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.locations_systempropertydynamiccrossref
  ADD CONSTRAINT property_record_locations_systempropertydynamiccrossref_fk
FOREIGN KEY (propertyrecord_id)
REFERENCES hat.system_propertyrecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.locations_systempropertystaticcrossref
  ADD CONSTRAINT property_record_locations_systempropertystaticcrossref_fk
FOREIGN KEY (propertyrecord_id)
REFERENCES hat.system_propertyrecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.organisations_systempropertydynamiccrossref
  ADD CONSTRAINT property_record_organisations_systempropertydynamiccrossref_fk
FOREIGN KEY (propertyrecord_id)
REFERENCES hat.system_propertyrecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.organisations_systempropertystaticcrossref
  ADD CONSTRAINT property_record_organisations_systempropertystaticcrossref_fk
FOREIGN KEY (propertyrecord_id)
REFERENCES hat.system_propertyrecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.people_systempropertydynamiccrossref
  ADD CONSTRAINT property_record_people_systempropertydynamiccrossref_fk
FOREIGN KEY (propertyrecord_id)
REFERENCES hat.system_propertyrecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.people_systempropertystaticcrossref
  ADD CONSTRAINT property_record_people_systempropertystaticcrossref_fk
FOREIGN KEY (propertyrecord_id)
REFERENCES hat.system_propertyrecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.things_systempropertydynamiccrossref
  ADD CONSTRAINT property_record_things_systempropertydynamiccrossref_fk
FOREIGN KEY (propertyrecord_id)
REFERENCES hat.system_propertyrecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.things_systempropertystaticcrossref
  ADD CONSTRAINT property_record_things_systempropertystaticcrossref_fk
FOREIGN KEY (propertyrecord_id)
REFERENCES hat.system_propertyrecord (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.events_systempropertydynamiccrossref
  ADD CONSTRAINT system_property_events_systempropertydynamiccrossref_fk
FOREIGN KEY (system_property_id)
REFERENCES hat.system_property (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.events_systempropertystaticcrossref
  ADD CONSTRAINT system_property_events_systempropertystaticcrossref_fk
FOREIGN KEY (system_property_id)
REFERENCES hat.system_property (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.locations_systempropertydynamiccrossref
  ADD CONSTRAINT system_property_locations_systempropertydynamiccrossref_fk
FOREIGN KEY (system_property_id)
REFERENCES hat.system_property (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.locations_systempropertystaticcrossref
  ADD CONSTRAINT system_property_locations_systempropertystaticcrossref_fk
FOREIGN KEY (system_property_id)
REFERENCES hat.system_property (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.organisations_systempropertydynamiccrossref
  ADD CONSTRAINT system_property_organisations_systempropertydynamiccrossref_fk
FOREIGN KEY (system_property_id)
REFERENCES hat.system_property (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.organisations_systempropertystaticcrossref
  ADD CONSTRAINT system_property_organisations_systempropertystaticcrossref_fk
FOREIGN KEY (system_property_id)
REFERENCES hat.system_property (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.people_systempropertydynamiccrossref
  ADD CONSTRAINT system_property_people_systempropertydynamiccrossref_fk
FOREIGN KEY (system_property_id)
REFERENCES hat.system_property (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.people_systempropertystaticcrossref
  ADD CONSTRAINT system_property_people_systempropertystaticcrossref_fk
FOREIGN KEY (system_property_id)
REFERENCES hat.system_property (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.things_systempropertydynamiccrossref
  ADD CONSTRAINT system_property_things_systempropertydynamiccrossref_fk
FOREIGN KEY (system_property_id)
REFERENCES hat.system_property (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.things_systempropertystaticcrossref
  ADD CONSTRAINT thing_property_id_refs_id_fk
FOREIGN KEY (system_property_id)
REFERENCES hat.system_property (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE hat.people_persontopersoncrossref
  ADD CONSTRAINT relationship_type_id_refs_id_fk
FOREIGN KEY (relationship_type_id)
REFERENCES hat.people_persontopersonrelationshiptype (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE hat.entity
  ADD CONSTRAINT people_person_entity_fk
FOREIGN KEY (person_id)
REFERENCES hat.people_person (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.events_eventpersoncrossref
  ADD CONSTRAINT people_person_people_eventpersoncrossref_fk
FOREIGN KEY (person_id)
REFERENCES hat.people_person (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.people_personlocationcrossref
  ADD CONSTRAINT person_id_refs_id
FOREIGN KEY (person_id)
REFERENCES hat.people_person (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE hat.people_personorganisationcrossref
  ADD CONSTRAINT person_id_refs_id_fk
FOREIGN KEY (person_id)
REFERENCES hat.people_person (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE hat.people_persontopersoncrossref
  ADD CONSTRAINT people_persontopersoncrossref_person_one_id_fkey
FOREIGN KEY (person_one_id)
REFERENCES hat.people_person (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE hat.people_persontopersoncrossref
  ADD CONSTRAINT people_persontopersoncrossref_person_two_id_fkey
FOREIGN KEY (person_two_id)
REFERENCES hat.people_person (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE hat.people_systempropertydynamiccrossref
  ADD CONSTRAINT people_person_people_systempropertydynamiccrossref_fk
FOREIGN KEY (person_id)
REFERENCES hat.people_person (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.people_systempropertystaticcrossref
  ADD CONSTRAINT people_person_people_systempropertystaticcrossref_fk
FOREIGN KEY (person_id)
REFERENCES hat.people_person (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.people_systemtypecrossref
  ADD CONSTRAINT people_person_people_systemtypecrossref_fk
FOREIGN KEY (users_id)
REFERENCES hat.people_person (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.things_thingpersoncrossref
  ADD CONSTRAINT owner_id_refs_id
FOREIGN KEY (person_id)
REFERENCES hat.people_person (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE hat.entity
  ADD CONSTRAINT organisations_organisation_entity_fk
FOREIGN KEY (organisation_id)
REFERENCES hat.organisations_organisation (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.events_eventorganisationcrossref
  ADD CONSTRAINT organisations_organisation_events_eventorganisationcrossref_fk
FOREIGN KEY (organisation_id)
REFERENCES hat.organisations_organisation (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.organisations_organisationlocationcrossref
  ADD CONSTRAINT organisations_organisationlocationcrossref_organisation_id_fkey
FOREIGN KEY (organisation_id)
REFERENCES hat.organisations_organisation (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE hat.organisations_organisationthingcrossref
  ADD CONSTRAINT organisations_organisation_organisations_organisationthingcr474
FOREIGN KEY (organisation_id)
REFERENCES hat.organisations_organisation (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.organisations_organisationtoorganisationcrossref
  ADD CONSTRAINT organisations_organisation_organisation_organisationtoorgani876
FOREIGN KEY (organisation_one_id)
REFERENCES hat.organisations_organisation (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.organisations_organisationtoorganisationcrossref
  ADD CONSTRAINT organisations_organisation_organisation_organisationtoorgani645
FOREIGN KEY (organisation_two_id)
REFERENCES hat.organisations_organisation (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.organisations_systempropertydynamiccrossref
  ADD CONSTRAINT organisations_organisation_organisations_systempropertydynam75
FOREIGN KEY (organisation_id)
REFERENCES hat.organisations_organisation (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.organisations_systempropertystaticcrossref
  ADD CONSTRAINT organisations_organisation_organisations_systempropertystati434
FOREIGN KEY (organisation_id)
REFERENCES hat.organisations_organisation (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.organisations_systemtypecrossref
  ADD CONSTRAINT organisations_organisation_organisations_systemtypecrossref_fk
FOREIGN KEY (organisation_id)
REFERENCES hat.organisations_organisation (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.people_personorganisationcrossref
  ADD CONSTRAINT organisation_id_refs_id_fk
FOREIGN KEY (organisation_id)
REFERENCES hat.organisations_organisation (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE hat.entity
  ADD CONSTRAINT locations_location_entity_fk
FOREIGN KEY (location_id)
REFERENCES hat.locations_location (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.events_eventlocationcrossref
  ADD CONSTRAINT locations_location_events_eventlocationcrossref_fk
FOREIGN KEY (location_id)
REFERENCES hat.locations_location (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.locations_locationthingcrossref
  ADD CONSTRAINT locations_locationthingcrossref_location_id_fkey
FOREIGN KEY (location_id)
REFERENCES hat.locations_location (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE hat.locations_locationtolocationcrossref
  ADD CONSTRAINT locations_locationtolocationcrossref_loc_one_id_fkey
FOREIGN KEY (loc_one_id)
REFERENCES hat.locations_location (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE hat.locations_locationtolocationcrossref
  ADD CONSTRAINT locations_locationtolocationcrossref_loc_two_id_fkey
FOREIGN KEY (loc_two_id)
REFERENCES hat.locations_location (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE hat.locations_systempropertydynamiccrossref
  ADD CONSTRAINT locations_location_locations_systempropertydynamiccrossref_fk
FOREIGN KEY (location_id)
REFERENCES hat.locations_location (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.locations_systempropertystaticcrossref
  ADD CONSTRAINT locations_location_locations_systempropertystaticcrossref_fk
FOREIGN KEY (location_id)
REFERENCES hat.locations_location (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.locations_systemtypecrossref
  ADD CONSTRAINT locations_location_location_systemtypecrossref_fk
FOREIGN KEY (location_id)
REFERENCES hat.locations_location (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.organisations_organisationlocationcrossref
  ADD CONSTRAINT locations_location_organisations_organisationlocationcrossre499
FOREIGN KEY (location_id)
REFERENCES hat.locations_location (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.people_personlocationcrossref
  ADD CONSTRAINT locations_locationpersoncrossref_location_id_fkey
FOREIGN KEY (location_id)
REFERENCES hat.locations_location (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE hat.entity
  ADD CONSTRAINT events_event_entity_fk
FOREIGN KEY (event_id)
REFERENCES hat.events_event (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.events_eventlocationcrossref
  ADD CONSTRAINT events_eventlocationcrossref_fk
FOREIGN KEY (event_id)
REFERENCES hat.events_event (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.events_eventorganisationcrossref
  ADD CONSTRAINT events_eventorganisationcrossref_fk
FOREIGN KEY (event_id)
REFERENCES hat.events_event (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.events_eventpersoncrossref
  ADD CONSTRAINT events_eventpersoncrossref_thing_id_fkey
FOREIGN KEY (event_id)
REFERENCES hat.events_event (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE hat.events_eventthingcrossref
  ADD CONSTRAINT events_eventthingcrossref_fk
FOREIGN KEY (event_id)
REFERENCES hat.events_event (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.events_eventtoeventcrossref
  ADD CONSTRAINT event_one_id_refs_id_fk
FOREIGN KEY (event_one_id)
REFERENCES hat.events_event (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE hat.events_eventtoeventcrossref
  ADD CONSTRAINT event_two_id_refs_id_fk
FOREIGN KEY (event_two_id)
REFERENCES hat.events_event (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE hat.events_systempropertydynamiccrossref
  ADD CONSTRAINT events_systempropertydynamiccrossref_fk
FOREIGN KEY (event_id)
REFERENCES hat.events_event (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.events_systempropertystaticcrossref
  ADD CONSTRAINT events_systempropertycrossref_fk
FOREIGN KEY (event_id)
REFERENCES hat.events_event (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.events_systemtypecrossref
  ADD CONSTRAINT events_systemtypecrossref_fk
FOREIGN KEY (event_id)
REFERENCES hat.events_event (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.bundle_context_entity_selection
  ADD CONSTRAINT entity_entity_selection_fk
FOREIGN KEY (entity_id)
REFERENCES hat.entity (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.bundle_contextless_table
  ADD CONSTRAINT data_table_bundle_contextless_table_fk
FOREIGN KEY (data_table)
REFERENCES hat.data_table (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.bundle_contextless_table_slice
  ADD CONSTRAINT data_table_bundle_contextless_table_slice_fk
FOREIGN KEY (data_table_id)
REFERENCES hat.data_table (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.data_field
  ADD CONSTRAINT data_table_fk
FOREIGN KEY (table_id_fk)
REFERENCES hat.data_table (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.data_tabletotablecrossref
  ADD CONSTRAINT data_table_data_tabletotablecrossref_fk
FOREIGN KEY (table2)
REFERENCES hat.data_table (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.data_tabletotablecrossref
  ADD CONSTRAINT data_table_data_tabletotablecrossref_fk1
FOREIGN KEY (table1)
REFERENCES hat.data_table (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.data_value
  ADD CONSTRAINT data_record_data_value_fk
FOREIGN KEY (record_id)
REFERENCES hat.data_record (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.events_systempropertystaticcrossref
  ADD CONSTRAINT data_record_events_systempropertystaticcrossref_fk
FOREIGN KEY (record_id)
REFERENCES hat.data_record (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.locations_systempropertystaticcrossref
  ADD CONSTRAINT data_record_locations_systempropertystaticcrossref_fk
FOREIGN KEY (record_id)
REFERENCES hat.data_record (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.organisations_systempropertystaticcrossref
  ADD CONSTRAINT data_record_organisations_systempropertystaticcrossref_fk
FOREIGN KEY (record_id)
REFERENCES hat.data_record (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.people_systempropertystaticcrossref
  ADD CONSTRAINT data_record_people_systempropertystaticcrossref_fk
FOREIGN KEY (record_id)
REFERENCES hat.data_record (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.things_systempropertystaticcrossref
  ADD CONSTRAINT data_record_things_systempropertycrossref_fk
FOREIGN KEY (record_id)
REFERENCES hat.data_record (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.bundle_contextless_join
  ADD CONSTRAINT data_field_bundle_contextless_join_fk1
FOREIGN KEY (bundle_contextless_table_field)
REFERENCES hat.data_field (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.data_debit
  ADD CONSTRAINT bundle_contextless_data_debit_fk
FOREIGN KEY (bundle_contextless_id)
REFERENCES hat.bundle_contextless (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.data_debit
  ADD CONSTRAINT bundle_context_data_debit_fk
FOREIGN KEY (bundle_context_id)
REFERENCES hat.bundle_context (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.bundle_contextless_join
  ADD CONSTRAINT data_field_bundle_contextless_join_fk
FOREIGN KEY (bundle_contextless_join_field)
REFERENCES hat.data_field (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.bundle_contextless_table_slice_condition
  ADD CONSTRAINT data_field_bundle_contextless_table_slice_condition_fk
FOREIGN KEY (field_id)
REFERENCES hat.data_field (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.data_value
  ADD CONSTRAINT data_field_data_value_fk
FOREIGN KEY (field_id)
REFERENCES hat.data_field (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.events_systempropertydynamiccrossref
  ADD CONSTRAINT data_field_events_systempropertydynamiccrossref_fk
FOREIGN KEY (field_id)
REFERENCES hat.data_field (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.events_systempropertystaticcrossref
  ADD CONSTRAINT data_field_events_systempropertystaticcrossref_fk
FOREIGN KEY (field_id)
REFERENCES hat.data_field (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.locations_systempropertydynamiccrossref
  ADD CONSTRAINT data_field_locations_systempropertydynamiccrossref_fk
FOREIGN KEY (field_id)
REFERENCES hat.data_field (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.locations_systempropertystaticcrossref
  ADD CONSTRAINT data_field_locations_systempropertystaticcrossref_fk
FOREIGN KEY (field_id)
REFERENCES hat.data_field (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.organisations_systempropertydynamiccrossref
  ADD CONSTRAINT data_field_organisations_systempropertydynamiccrossref_fk
FOREIGN KEY (field_id)
REFERENCES hat.data_field (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.organisations_systempropertystaticcrossref
  ADD CONSTRAINT data_field_organisations_systempropertystaticcrossref_fk
FOREIGN KEY (field_id)
REFERENCES hat.data_field (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.people_systempropertydynamiccrossref
  ADD CONSTRAINT data_field_people_systempropertydynamiccrossref_fk
FOREIGN KEY (field_id)
REFERENCES hat.data_field (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.people_systempropertystaticcrossref
  ADD CONSTRAINT data_field_people_systempropertystaticcrossref_fk
FOREIGN KEY (field_id)
REFERENCES hat.data_field (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.things_systempropertydynamiccrossref
  ADD CONSTRAINT data_field_things_systempropertydynamiccrossref_fk
FOREIGN KEY (field_id)
REFERENCES hat.data_field (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.things_systempropertystaticcrossref
  ADD CONSTRAINT data_field_things_systempropertystaticcrossref_fk
FOREIGN KEY (field_id)
REFERENCES hat.data_field (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.bundle_contextless_join
  ADD CONSTRAINT bundle_contextless_table_bundle_join_fk
FOREIGN KEY (bundle_contextless_table_id)
REFERENCES hat.bundle_contextless_table (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.bundle_contextless_table_slice
  ADD CONSTRAINT bundle_contextless_table_bundle_contextless_tableslice_fk
FOREIGN KEY (bundle_contextless_table_id)
REFERENCES hat.bundle_contextless_table (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.bundle_contextless_table_slice_condition
  ADD CONSTRAINT bundle_contextless_table_slice_condition_fk
FOREIGN KEY (table_slice_id)
REFERENCES hat.bundle_contextless_table_slice (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.bundle_contextless_join
  ADD CONSTRAINT bundle_contextless_bundle_contextless_join_fk
FOREIGN KEY (bundle_contextless_id)
REFERENCES hat.bundle_contextless (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.bundle_context_to_bundle_crossref
  ADD CONSTRAINT bundle_context_bundle_bundletobundlecrossref_fk
FOREIGN KEY (bundle_parent)
REFERENCES hat.bundle_context (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hat.bundle_context_to_bundle_crossref
  ADD CONSTRAINT bundle_context_bundle_bundletobundlecrossref_fk1
FOREIGN KEY (bundle_child)
REFERENCES hat.bundle_context (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;