delete from checkpoint_score where checkpoint_id in (10327, 10150, 10147, 10320, 10308, 10146, 10311, 10145, 10156, 10161, 10149, 10316, 10153, 10310, 10163, 10326, 10309, 10313, 10322, 10324, 10154);

delete from checkpoint where id in (10327, 10150, 10147, 10320, 10308, 10146, 10311, 10145, 10156, 10161, 10149, 10316, 10153, 10310, 10163, 10326, 10309, 10313, 10322, 10324, 10154);

update checkpoint_score set facility_assessment_id = 1 where facility_assessment_id = 2;
delete from facility_assessment where facility_assessment_id = 2;
-- Mortuary which has only one checkpoint filled (perhaps by mistake)
delete from checkpoint_score where facility_assessment_id = 1 and checklist_id = 17;

