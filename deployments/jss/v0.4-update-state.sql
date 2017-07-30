INSERT INTO state (name) VALUES ('Madhya Pradesh');
UPDATE checklist set state_id = (SELECT id from state where name = 'Madhya Pradesh');