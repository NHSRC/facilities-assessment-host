UPDATE checklist SET department_id = (SELECT id from department WHERE name = 'Labour Room') WHERE department_id = (SELECT id from department WHERE name = 'Labour room');
DELETE from department WHERE name = 'Labour room';
UPDATE checklist SET name = 'Labour Room' WHERE name = 'Labour room';

UPDATE checklist SET department_id = (SELECT id from department WHERE name = 'Pharmacy and Stores') WHERE department_id = (SELECT id from department WHERE name = 'Pharmacy');
DELETE from department WHERE name = 'Pharmacy';
UPDATE checklist SET name = 'Pharmacy and Stores' WHERE name = 'Pharmacy';

UPDATE checklist SET department_id = (SELECT id from department WHERE name = 'Operation Theatre') WHERE department_id = (SELECT id from department WHERE name = 'OT');
DELETE from department WHERE name = 'OT';
UPDATE checklist SET name = 'Operation Theatre' WHERE name = 'OT';

UPDATE department SET name = 'In Patient Department' WHERE name = 'IPD';
UPDATE checklist SET name = 'In Patient Department' WHERE name = 'IPD';
