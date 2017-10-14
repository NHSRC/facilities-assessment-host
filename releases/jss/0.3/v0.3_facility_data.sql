INSERT INTO state (name) VALUES ('Madhya Pradesh');

INSERT INTO district (name, state_id) VALUES ('Anuppur', (SELECT id from state where state.name = 'Madhya Pradesh'));
INSERT INTO district (name, state_id) VALUES ('Mandla', (SELECT id from state where state.name = 'Madhya Pradesh'));
INSERT INTO district (name, state_id) VALUES ('Sidhi', (SELECT id from state where state.name = 'Madhya Pradesh'));
INSERT INTO district (name, state_id) VALUES ('Umaria', (SELECT id from state where state.name = 'Madhya Pradesh'));

INSERT INTO facility (name, district_id, facility_type_id) VALUES ('CHC Pushprajgarh', (SELECT id from district WHERE district.name = 'Anuppur'), (SELECT id FROM facility_type WHERE facility_type.name = 'Community Health Center'));
INSERT INTO facility (name, district_id, facility_type_id) VALUES ('DH Anuppur', (SELECT id from district WHERE district.name = 'Anuppur'), (SELECT id FROM facility_type WHERE facility_type.name = 'District Hospital'));

INSERT INTO facility (name, district_id, facility_type_id) VALUES ('CHC Nainpur', (SELECT id from district WHERE district.name = 'Mandla'), (SELECT id FROM facility_type WHERE facility_type.name = 'Community Health Center'));
INSERT INTO facility (name, district_id, facility_type_id) VALUES ('DH Mandla', (SELECT id from district WHERE district.name = 'Mandla'), (SELECT id FROM facility_type WHERE facility_type.name = 'District Hospital'));

INSERT INTO facility (name, district_id, facility_type_id) VALUES ('CHC Rampur Naikin', (SELECT id from district WHERE district.name = 'Sidhi'), (SELECT id FROM facility_type WHERE facility_type.name = 'Community Health Center'));
INSERT INTO facility (name, district_id, facility_type_id) VALUES ('DH Sidhi', (SELECT id from district WHERE district.name = 'Sidhi'), (SELECT id FROM facility_type WHERE facility_type.name = 'District Hospital'));

INSERT INTO facility (name, district_id, facility_type_id) VALUES ('CHC Pali', (SELECT id from district WHERE district.name = 'Umaria'), (SELECT id FROM facility_type WHERE facility_type.name = 'Community Health Center'));
INSERT INTO facility (name, district_id, facility_type_id) VALUES ('DH Umaria', (SELECT id from district WHERE district.name = 'Umaria'), (SELECT id FROM facility_type WHERE facility_type.name = 'District Hospital'));