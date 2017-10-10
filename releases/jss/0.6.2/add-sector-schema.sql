CREATE TABLE sector (
  id                 SERIAL PRIMARY KEY,
  created_date       TIMESTAMP WITHOUT TIME ZONE DEFAULT now() :: TIMESTAMP   NOT NULL,
  last_modified_date TIMESTAMP WITHOUT TIME ZONE DEFAULT now() :: TIMESTAMP   NOT NULL,
  uuid               UUID DEFAULT uuid_generate_v4() UNIQUE                   NOT NULL,
  name               CHARACTER VARYING(1024) UNIQUE                           NOT NULL
);

CREATE TABLE sector_facility_mapping (
  id                 SERIAL PRIMARY KEY,
  created_date       TIMESTAMP WITHOUT TIME ZONE DEFAULT now() :: TIMESTAMP      NOT NULL,
  last_modified_date TIMESTAMP WITHOUT TIME ZONE DEFAULT now() :: TIMESTAMP      NOT NULL,
  uuid               UUID DEFAULT uuid_generate_v4() UNIQUE                      NOT NULL,
  sector_id          INT REFERENCES sector (id)                                  NOT NULL,
  facility_id        INT REFERENCES facility (id)                                NOT NULL
);