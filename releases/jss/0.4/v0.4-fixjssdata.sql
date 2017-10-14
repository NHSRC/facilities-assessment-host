-- FIX CG DATABASE
UPDATE public.checklist SET state_id = (SELECT id from state WHERE state.name = 'Chhattisgarh');

-- FIX JSS DATABASE
set search_path to mp;
INSERT INTO state (name) VALUES ('JSS');
INSERT INTO district (name, state_id) VALUES ('JSS', (SELECT id from state WHERE name = 'JSS'));
UPDATE facility SET district_id = (SELECT id from district WHERE district.name = 'JSS') WHERE name = 'Jan Swasthya Sahyog (JSS)';

UPDATE checklist SET state_id = (SELECT id from state WHERE state.name = 'JSS');
DELETE FROM district WHERE name = 'Bilaspur';
DELETE FROM state WHERE name = 'Chhattisgarh';

------------ Create a custom checklist for JSS
UPDATE checklist SET assessment_tool_id = (SELECT id from assessment_tool WHERE assessment_tool.name = 'District Hospital (DH)') WHERE assessment_tool_id not in (SELECT id from assessment_tool where name = 'Dakshata');
UPDATE checklist SET state_id = (SELECT id from state WHERE state.name = 'Madhya Pradesh') WHERE assessment_tool_id = (SELECT id from assessment_tool where name = 'Dakshata');

DELETE from checklist where name = 'Department Wise';
DELETE from department where name = 'Department Wise';