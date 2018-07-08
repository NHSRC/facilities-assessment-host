-- Labour Room
update measurable_element
set name = 'Access to facility is provided without any physical barrier & friendly to people with disabilities'
from checkpoint
  join checklist c2 on checkpoint.checklist_id = c2.id
  join assessment_tool a on c2.assessment_tool_id = a.id
where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
      and measurable_element.name = 'Access to facility is provided without any physical barrier & and friendly to people with disabilities'
      and c2.name = 'Labour Room';

update measurable_element
set name = 'The facility ensures the behaviors of staff is dignified and respectful, while delivering the services'
from checkpoint
  join checklist c2 on checkpoint.checklist_id = c2.id
  join assessment_tool a on c2.assessment_tool_id = a.id
where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
      and measurable_element.name = 'The facility ensures the behaviors of staff is dignified and respectful, while delivering the services'
      and c2.name = 'Labour Room';

update measurable_element
set name = 'There is established procedure for taking informed consent before treatment and procedures'
from checkpoint
  join checklist c2 on checkpoint.checklist_id = c2.id
  join assessment_tool a on c2.assessment_tool_id = a.id
where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
      and measurable_element.name = 'There is established procedures for taking informed consent before treatment and procedures'
      and c2.name = 'Labour Room';

update measurable_element
set name = 'Patient amenities are provided as per patient load'
from checkpoint
  join checklist c2 on checkpoint.checklist_id = c2.id
  join assessment_tool a on c2.assessment_tool_id = a.id
where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
      and measurable_element.name = 'Patient amenities are provide as per patient load'
      and c2.name = 'Labour Room';

update measurable_element
set name = 'The facility has an established procedure for duty roster and deputation to different departments'
from checkpoint
  join checklist c2 on checkpoint.checklist_id = c2.id
  join assessment_tool a on c2.assessment_tool_id = a.id
where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
      and measurable_element.name = 'The facility has a established procedure for duty roster and deputation to different departments'
      and c2.name = 'Labour Room';

update measurable_element
set name = 'Facility identifies non value adding activities / waste / redundant activities'
from checkpoint
  join checklist c2 on checkpoint.checklist_id = c2.id
  join assessment_tool a on c2.assessment_tool_id = a.id
where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
      and measurable_element.name = 'The facility identifies non value adding activities / waste / redundant activities'
      and c2.name = 'Labour Room';

update measurable_element
set name = 'Facility takes corrective action to improve the processes'
from checkpoint
  join checklist c2 on checkpoint.checklist_id = c2.id
  join assessment_tool a on c2.assessment_tool_id = a.id
where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
      and measurable_element.name = 'The facility takes corrective action to improve the processes'
      and c2.name = 'Labour Room';

update measurable_element
set name = 'Facility has defined quality objectives to achieve mission and quality policy'
from checkpoint
  join checklist c2 on checkpoint.checklist_id = c2.id
  join assessment_tool a on c2.assessment_tool_id = a.id
where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
      and measurable_element.name = 'Facility has de defined quality objectives to achieve mission and quality policy'
      and c2.name = 'Labour Room';

-- OT
-- update measurable_element
-- set name = 'The facility provides New-born health Services'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility provides Newborn health Services'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Access to facility is provided without any physical barrier & and friendly to people with disabilities'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'Access to facility is provided without any physical barrier & friendly to people with disabilities'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'The facility ensures the behavior of staff is dignified and respectful, while delivering the services'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility ensures the behaviours of staff is dignified and respectful, while delivering the services'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Exterior of the facility building is maintained appropriately'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'Exterior & Interior of the facility building is maintained appropriately'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility has established procedure for continuity of care during interdepartmental transfer'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility has established procedure for continuity of care during interdepartmental transfer'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility ensured that drugs are prescribed in generic name only'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility ensured that drugs are prescribed in generic name only'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'There is process for identifying and cautious administration of high alert drugs (to check)'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'There is process for identifying and cautious administration of high alert drugs'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility has established procedures for Post Anesthesia care'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'Facility has established procedures for Post Anaesthesia care'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility staff adheres to standard protocols for identification and management of Pre Eclampsia / Ecalmpsia'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'Facility staff adheres to standard protocols for identification and management of Pre Eclampsia / Eclampsia'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Stabilization/treatment/referral of post natal complication'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility has established procedures for stabilization/treatment/referral of post natal complications'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility has provision for Passive and active culture surveillance of critical & high risk areas'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility has provision for Passive and active culture surveillance of critical & high risk areas'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility has provision for Passive and active culture surveillance of critical & high risk areas'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility has provision for Passive and active culture surveillance of critical & high risk areas'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'There is Provision of Periodic Medical Check-ups and immunization of staff'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'There is Provision of Periodic Medical Check-up and immunization of staff'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility has established procedures for regular monitoring of infection control practices'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility has established procedures for regular monitoring of infection control practices'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Staff is trained and adhere to standard hand washing practices'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility staff is trained in hand washing practices and they adhere to standard hand washing practices'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility ensures standard practices and materials for antisepsis'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility ensures standard practices and materials for antisepsis'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility ensures adequate personal protection equipment''s as per requirements'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility ensures adequate personal protection Equipment as per requirements'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Staff is adhere to standard personal protection practices'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility staff adheres to standard personal protection practices'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility ensures standard practices and materials for decontamination and clean in of instruments and procedures areas'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility ensures standard practices and materials for decontamination and cleaning of instruments and procedures areas'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Functional area of the department are arranged to ensure infection control practices'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'Layout of the department is conducive for the infection control practices'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility ensures availability of standard materials for cleaning and disinfection of patient care areas'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility ensures availability of standard materials for cleaning and disinfection of patient care areas'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility ensures standard practices followed for cleaning and disinfection of patient care areas'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility ensures standard practices are followed for the cleaning and disinfection of patient care areas'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility Ensures segregation of Bio Medical Waste as per guidelines'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name =
--           'The facility Ensures segregation of Bio Medical Waste as per guidelines and ''on-site'' management of waste is carried out as per guidelines'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility ensures management of sharps as per guidelines'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility ensures management of sharps as per guidelines'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility ensures transportation and disposal of waste as per guidelines'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility ensures transportation and disposal of waste as per guidelines'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility has established internal quality assurance program at relevant departments'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility has established internal quality assurance programme in key departments'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility has established system for use of check lists in different departments and services'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility has established system for use of check lists in different departments and services'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Staff is trained and aware of the standard procedures written in SOPs'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'Staff is trained and aware of the procedures written in SOPs'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility maps its critical processes'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility maps its critical processes'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility identifies non value adding activities / waste / redundant activities'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility identifies non value adding activities / waste / redundant activities'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility takes corrective action to improve the processes'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility takes corrective action to improve the processes'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility uses method for quality improvement in services'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility uses method for quality improvement in services'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility uses tools for quality improvement in services'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility uses tools for quality improvement in services'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Post partum Care is Provided to Mother'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'Facility staff adheres to protocol for assessment of condition of mother and baby and providing adequate postpartum care'
--       and c2.name = 'OT';
-- --
-- -- update measurable_element
-- -- set name = 'Emergency drug trays are maintained at every point of care, wherever it may be needed'
-- -- from checkpoint
-- --   join checklist c2 on checkpoint.checklist_id = c2.id
-- --   join assessment_tool a on c2.assessment_tool_id = a.id
-- -- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
-- --       and measurable_element.name = 'Emergency drug trays are maintained at every point of care, where ever it may be needed'
-- --       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility staff adheres to standard procedures for routine care of newborn immediately after birth'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'Facility staff adheres to standard procedures for routine care of new-born immediately after birth'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility ensures standard practices and materials for disinfection and sterilization of instruments and equipment''s'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'The facility ensures standard practices and materials for disinfection and sterilization of instruments and equipment'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'There is established procedures for taking informed consent before treatment and procedures'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'There is established procedure for taking informed consent before treatment and procedures'
--       and c2.name = 'OT';
--
-- update measurable_element
-- set name = 'Facility has de defined quality objectives to achieve mission and quality policy'
-- from checkpoint
--   join checklist c2 on checkpoint.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS' and checkpoint.measurable_element_id = measurable_element.id
--       and measurable_element.name = 'Facility has defined quality objectives to achieve mission and quality policy'
--       and c2.name = 'OT';

-- select measurable_element.id, measurable_element.name, measurable_element.reference
-- from measurable_element
--   join checkpoint c3 on measurable_element.id = c3.measurable_element_id
--   join checklist c2 on c3.checklist_id = c2.id
--   join assessment_tool a on c2.assessment_tool_id = a.id
-- where a.name = 'NQAS'
--   and measurable_element.reference like '%19.1%'
-- order by measurable_element.id;

select
  measurable_element.id,
  measurable_element.name me,
  c3.name,
  measurable_element.reference
from measurable_element
  join checkpoint c3 on measurable_element.id = c3.measurable_element_id
  join checklist c2 on c3.checklist_id = c2.id
  join assessment_tool a on c2.assessment_tool_id = a.id
where a.name = 'NQAS'
      and measurable_element.name like '%The facility provides Newborn health Services%'
      and c2.name = 'Labour Room'
--   and c3.name = 'Provides ART for seropositive mothers/ links with ART center'
--   and c2.uuid = '2a7f47e6-4c85-4fe4-b975-76193d725447'
order by measurable_element.id;



-- The facility ensures the behaviors of staff is dignified and respectful, while delivering the services
-- The facility has provision for Passive and active culture surveillance of critical & high risk areas
-- The facility identifies non value adding activities / waste / redundant activities
-- The facility takes corrective action to improve the processes