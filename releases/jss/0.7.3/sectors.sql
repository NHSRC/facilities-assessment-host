INSERT into sector (name) VALUES ('Karpa');
INSERT into sector (name) VALUES ('Khamraudh');

INSERT INTO sector_facility_mapping (sector_id, facility_id) VALUES ((SELECT id from sector WHERE name = 'Karpa'), (SELECT id from facility WHERE name = 'CHC Karpa'));
INSERT INTO sector_facility_mapping (sector_id, facility_id) VALUES ((SELECT id from sector WHERE name = 'Karpa'), (SELECT id from facility WHERE name = 'SC Ledhra'));
INSERT INTO sector_facility_mapping (sector_id, facility_id) VALUES ((SELECT id from sector WHERE name = 'Karpa'), (SELECT id from facility WHERE name = 'SC Gonda'));
INSERT INTO sector_facility_mapping (sector_id, facility_id) VALUES ((SELECT id from sector WHERE name = 'Karpa'), (SELECT id from facility WHERE name = 'SC Ahlavar'));
INSERT INTO sector_facility_mapping (sector_id, facility_id) VALUES ((SELECT id from sector WHERE name = 'Karpa'), (SELECT id from facility WHERE name = 'SC Dudhmaniya'));
INSERT INTO sector_facility_mapping (sector_id, facility_id) VALUES ((SELECT id from sector WHERE name = 'Karpa'), (SELECT id from facility WHERE name = 'SC Padari'));
INSERT INTO sector_facility_mapping (sector_id, facility_id) VALUES ((SELECT id from sector WHERE name = 'Karpa'), (SELECT id from facility WHERE name = 'SC Nagula'));
INSERT INTO sector_facility_mapping (sector_id, facility_id) VALUES ((SELECT id from sector WHERE name = 'Karpa'), (SELECT id from facility WHERE name = 'SC Ufarikala'));
INSERT INTO sector_facility_mapping (sector_id, facility_id) VALUES ((SELECT id from sector WHERE name = 'Karpa'), (SELECT id from facility WHERE name = 'SC Karpa'));

INSERT INTO sector_facility_mapping (sector_id, facility_id) VALUES ((SELECT id from sector WHERE name = 'Khamraudh'), (SELECT id from facility WHERE name = 'PHC Khamrod'));
INSERT INTO sector_facility_mapping (sector_id, facility_id) VALUES ((SELECT id from sector WHERE name = 'Khamraudh'), (SELECT id from facility WHERE name = 'SC Jaitahari'));
INSERT INTO sector_facility_mapping (sector_id, facility_id) VALUES ((SELECT id from sector WHERE name = 'Khamraudh'), (SELECT id from facility WHERE name = 'SC Dhuradhar'));
INSERT INTO sector_facility_mapping (sector_id, facility_id) VALUES ((SELECT id from sector WHERE name = 'Khamraudh'), (SELECT id from facility WHERE name = 'SC Kharsol'));
INSERT INTO sector_facility_mapping (sector_id, facility_id) VALUES ((SELECT id from sector WHERE name = 'Khamraudh'), (SELECT id from facility WHERE name = 'SC Baditumbi'));
INSERT INTO sector_facility_mapping (sector_id, facility_id) VALUES ((SELECT id from sector WHERE name = 'Khamraudh'), (SELECT id from facility WHERE name = 'SC Khamraudh'));