UPDATE department set name = 'Blood Storage Unit' WHERE name = 'Blood storage unit';
UPDATE department set name = 'Auxillary Services' WHERE name = 'Auxillary services';
UPDATE department set name = 'Labour Room' WHERE name = 'Labour room';

UPDATE checklist AS c
SET department_id = foo.first_id
FROM (SELECT MIN (id) first_id, name FROM department GROUP BY NAME) AS foo
WHERE foo.name = (SELECT name from department WHERE c.department_id = department.id);

DELETE FROM department WHERE id not in (SELECT min(id) from department GROUP BY NAME);

UPDATE checklist SET department_id = (SELECT id from department WHERE  name = 'IPD') WHERE department_id = (SELECT id from department WHERE name = 'In Patient Department');
DELETE from department WHERE name = 'In Patient Department';