-- Move maternity OT checklist into NQAS.
delete from facility_assessment_device where facility_assessment_id = (select id from facility_assessment where assessment_tool_id = (select id from assessment_tool where name = 'Maternity Services'));
delete from facility_assessment where assessment_tool_id = (select id from assessment_tool where name = 'Maternity Services');
update checklist set assessment_tool_id = (select id from assessment_tool where name = 'District Hospital (DH)'), name ='Maternity OT' where name = 'OT';
delete from assessment_tool where name = 'Maternity Services';
delete from assessment_tool_mode where name = 'Maternity Services';

-- ANC OPD checklist should be moved into a program of its own.
insert into assessment_tool_mode (name) values ('ANC Program');
insert into assessment_tool (name, assessment_tool_mode_id) values ('ANC Tool', (select id from assessment_tool_mode where name = 'ANC Program'));
update checklist set assessment_tool_id = (select id from assessment_tool where name = 'ANC Tool') where name = 'ANC OPD';