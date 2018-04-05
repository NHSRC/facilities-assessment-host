delete from checkpoint_score where facility_assessment_id in (select id from facility_assessment where id > 9);
delete from facility_assessment_device where facility_assessment_id in (select id from facility_assessment where id > 9);
delete from facility_assessment where id in (select id from facility_assessment where id > 9);