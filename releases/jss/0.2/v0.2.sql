-- https://trello.com/c/nQYGQFIq/36-bug-in-chc-kotacg-assessment-app-in-bsu-area-of-concern-c-many-checkpoints-are-repeated

UPDATE checkpoint_score set checkpoint_id = 10325 WHERE checkpoint_id = 10150 and facility_assessment_id = 4;
UPDATE checkpoint_score set checkpoint_id = 10323 WHERE checkpoint_id = 10154 and facility_assessment_id = 4;
UPDATE checkpoint_score set checkpoint_id = 10315 WHERE checkpoint_id = 10146 and facility_assessment_id = 4;
UPDATE checkpoint_score set checkpoint_id = 10319 WHERE checkpoint_id = 10145 and facility_assessment_id = 4;
UPDATE checkpoint_score set checkpoint_id = 10307 WHERE checkpoint_id = 10156 and facility_assessment_id = 4;
UPDATE checkpoint_score set checkpoint_id = 10317 WHERE checkpoint_id = 10149 and facility_assessment_id = 4;
UPDATE checkpoint_score set checkpoint_id = 10321 WHERE checkpoint_id = 10153 and facility_assessment_id = 4;
UPDATE checkpoint_score set checkpoint_id = 10312 WHERE checkpoint_id = 10163 and facility_assessment_id = 4;
UPDATE checkpoint_score set checkpoint_id = 10318 WHERE checkpoint_id = 10147 and facility_assessment_id = 4;
UPDATE checkpoint_score set checkpoint_id = 10314 WHERE checkpoint_id = 10161 and facility_assessment_id = 4;

DELETE from checkpoint_score where checkpoint_id in (10327, 10150, 10147, 10320, 10308, 10146, 10311, 10145, 10156, 10161, 10149, 10316, 10153, 10310, 10163, 10326, 10309, 10313, 10322, 10324, 10154) and facility_assessment_id = 3;
DELETE from checkpoint_score where checkpoint_id in (10313) and facility_assessment_id = 4;

delete from checkpoint where id in (10327, 10150, 10147, 10320, 10308, 10146, 10311, 10145, 10156, 10161, 10149, 10316, 10153, 10310, 10163, 10326, 10309, 10313, 10322, 10324, 10154);

update checkpoint_score set facility_assessment_id = 1 where facility_assessment_id = 2;
delete from facility_assessment where id = 2;
-- Mortuary which has only one checkpoint filled (perhaps by mistake)
delete from checkpoint_score where facility_assessment_id = 1 and checklist_id = 17;