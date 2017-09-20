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

--- Multiple assessments done for DH-BSP
UPDATE facility_assessment SET series_name = '1' WHERE series_name = 'dakshata  1';
DELETE from checkpoint_score where checklist_id = 16 and facility_assessment_id = 49;
UPDATE checkpoint_score set facility_assessment_id = 46 WHERE facility_assessment_id in (47, 49, 50, 52);
DELETE from facility_assessment WHERE id in (47, 49, 50, 52);
UPDATE facility_assessment set series_name = '1' WHERE id = 46;

-- DAKSHATA checklist fix
UPDATE area_of_concern SET name = 'Availability of resources', reference = 'Form 2' WHERE name = 'Availability of Resources';
UPDATE area_of_concern SET name = 'Labour room standards', reference = 'Form 3' WHERE name = 'Labor room';
UPDATE area_of_concern SET name = 'MNH Program (Practices)', reference = 'Form 4' WHERE name = 'MNH Programme';

UPDATE checklist_area_of_concern set checklist_id = (SELECT id from checklist WHERE name = 'Form 2' and state_id = (SELECT id from state WHERE name = 'Chhattisgarh')) WHERE checklist_id = (SELECT id from checklist WHERE name = 'Form 3' and state_id = (SELECT id from state WHERE name = 'Chhattisgarh'));
UPDATE checklist_area_of_concern set checklist_id = (SELECT id from checklist WHERE name = 'Form 2' and state_id = (SELECT id from state WHERE name = 'Chhattisgarh')) WHERE checklist_id = (SELECT id from checklist WHERE name = 'Form 4' and state_id = (SELECT id from state WHERE name = 'Chhattisgarh'));
UPDATE checklist_area_of_concern set checklist_id = (SELECT id from checklist WHERE name = 'Form 2' and state_id = (SELECT id from state WHERE name = 'Madhya Pradesh')) WHERE checklist_id = (SELECT id from checklist WHERE name = 'Form 3' and state_id = (SELECT id from state WHERE name = 'Madhya Pradesh'));
UPDATE checklist_area_of_concern set checklist_id = (SELECT id from checklist WHERE name = 'Form 2' and state_id = (SELECT id from state WHERE name = 'Madhya Pradesh')) WHERE checklist_id = (SELECT id from checklist WHERE name = 'Form 4' and state_id = (SELECT id from state WHERE name = 'Madhya Pradesh'));

UPDATE checkpoint SET checklist_id = (SELECT id from checklist WHERE name = 'Form 2' and state_id = (SELECT id from state WHERE name = 'Chhattisgarh')) WHERE checklist_id = (SELECT id from checklist WHERE name = 'Form 3' and state_id = (SELECT id from state WHERE name = 'Chhattisgarh'));
UPDATE checkpoint SET checklist_id = (SELECT id from checklist WHERE name = 'Form 2' and state_id = (SELECT id from state WHERE name = 'Chhattisgarh')) WHERE checklist_id = (SELECT id from checklist WHERE name = 'Form 4' and state_id = (SELECT id from state WHERE name = 'Chhattisgarh'));
UPDATE checkpoint SET checklist_id = (SELECT id from checklist WHERE name = 'Form 2' and state_id = (SELECT id from state WHERE name = 'Madhya Pradesh')) WHERE checklist_id = (SELECT id from checklist WHERE name = 'Form 3' and state_id = (SELECT id from state WHERE name = 'Madhya Pradesh'));
UPDATE checkpoint SET checklist_id = (SELECT id from checklist WHERE name = 'Form 2' and state_id = (SELECT id from state WHERE name = 'Madhya Pradesh')) WHERE checklist_id = (SELECT id from checklist WHERE name = 'Form 4' and state_id = (SELECT id from state WHERE name = 'Madhya Pradesh'));

UPDATE checkpoint_score SET checklist_id = (SELECT id from checklist WHERE name = 'Form 2' and state_id = (SELECT id from state WHERE name = 'Chhattisgarh')) WHERE checklist_id = (SELECT id from checklist WHERE name = 'Form 3' and state_id = (SELECT id from state WHERE name = 'Chhattisgarh'));
UPDATE checkpoint_score SET checklist_id = (SELECT id from checklist WHERE name = 'Form 2' and state_id = (SELECT id from state WHERE name = 'Chhattisgarh')) WHERE checklist_id = (SELECT id from checklist WHERE name = 'Form 4' and state_id = (SELECT id from state WHERE name = 'Chhattisgarh'));
UPDATE checkpoint_score SET checklist_id = (SELECT id from checklist WHERE name = 'Form 2' and state_id = (SELECT id from state WHERE name = 'Madhya Pradesh')) WHERE checklist_id = (SELECT id from checklist WHERE name = 'Form 3' and state_id = (SELECT id from state WHERE name = 'Madhya Pradesh'));
UPDATE checkpoint_score SET checklist_id = (SELECT id from checklist WHERE name = 'Form 2' and state_id = (SELECT id from state WHERE name = 'Madhya Pradesh')) WHERE checklist_id = (SELECT id from checklist WHERE name = 'Form 4' and state_id = (SELECT id from state WHERE name = 'Madhya Pradesh'));

DELETE FROM checklist WHERE name = 'Form 3';
DELETE FROM checklist WHERE name = 'Form 4';
UPDATE checklist SET name = 'Dakshata Checklist', department_id = (SELECT id FROM department WHERE name = 'Labour Room') WHERE name = 'Form 2';

-- remove kayakalp option
DELETE from assessment_tool_mode WHERE name = 'kayakalp';

--- fix bad measurable elements with double dots in the name
UPDATE checkpoint set measurable_element_id = 387 WHERE measurable_element_id = 383;
UPDATE checkpoint set measurable_element_id = 84 WHERE measurable_element_id = 83;
UPDATE checkpoint set measurable_element_id = 1666 WHERE measurable_element_id = 1669;
UPDATE checkpoint set measurable_element_id = 841 WHERE measurable_element_id = 844;

DELETE from measurable_element WHERE id in (383, 83, 1669, 844);