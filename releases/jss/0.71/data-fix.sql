-- CG - Dakshata Series 1 should be removed for CHC Lormi, DH Mungeli and DH Bilaspur. 2 to become 1 and 3 to become 2 for those facilities
DELETE from checkpoint_score WHERE facility_assessment_id = 23;
DELETE from facility_assessment WHERE id = 23;
UPDATE facility_assessment SET series_name = '1' WHERE id = 71;
UPDATE facility_assessment SET series_name = '2' WHERE id = 81;

DELETE from checkpoint_score WHERE facility_assessment_id = 48;
DELETE from facility_assessment WHERE id = 48;
UPDATE facility_assessment SET series_name = '1' WHERE id = 61;
UPDATE facility_assessment SET series_name = '2' WHERE id = 70;

DELETE from checkpoint_score WHERE facility_assessment_id = 51;
DELETE from facility_assessment WHERE id = 51;
UPDATE facility_assessment SET series_name = '1' WHERE id = 69;


-- General Administration & Admin are the same
UPDATE checklist SET department_id = (SELECT id from department WHERE name = 'General Administration') WHERE department_id = (SELECT id from department WHERE name = 'Admin');
DELETE from department WHERE name = 'Admin';
UPDATE checklist SET name = 'General Administration' WHERE name = 'Admin';

-- Laboratory & Lab are the same
UPDATE checklist SET department_id = (SELECT id from department WHERE name = 'Laboratory') WHERE department_id = (SELECT id from department WHERE name = 'Lab');
DELETE from department WHERE name = 'Lab';
UPDATE checklist SET name = 'Laboratory' WHERE name = 'Lab';

-- Remove Dakshata assessment #2 for DH Anuppur & CHC Pushparajgarh
DELETE from checkpoint_score WHERE facility_assessment_id = 43;
DELETE from facility_assessment WHERE id = 43;
UPDATE facility_assessment SET series_name = '2' WHERE id = 76;

DELETE from checkpoint_score WHERE facility_assessment_id = 72;
DELETE from facility_assessment WHERE id = 72;
UPDATE facility_assessment SET series_name = '2' WHERE id = 72;