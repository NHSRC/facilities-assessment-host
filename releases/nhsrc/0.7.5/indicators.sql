INSERT INTO assessment_tool (name, assessment_tool_mode_id) VALUES ('LAQSHYA Indicators', (SELECT id from assessment_tool_mode WHERE name = 'LAQSHYA'));
UPDATE assessment_tool SET type = 'INDICATOR' WHERE name = 'LAQSHYA Indicators';


CREATE OR REPLACE FUNCTION setup_laqshya_indicators()
  RETURNS VOID AS $$
DECLARE at_id INT;
BEGIN
  SELECT id into at_id from assessment_tool WHERE name = 'LAQSHYA Indicators';

  INSERT INTO indicator_definition (name, data_type, sort_order, assessment_tool_id) VALUES ('Reporting Month', 'Month', 100,  at_id);
  INSERT INTO indicator_definition (name, data_type, sort_order, assessment_tool_id) VALUES ('Date of Visit', 'Date', 200, at_id);


  INSERT INTO indicator_definition (name, data_type, symbol, description, sort_order, assessment_tool_id) VALUES ('Total number of normal vaginal deliveries', 'Numeric', 'vagDel', 'This number will be derived from labour room register', 300, at_id);
  INSERT INTO indicator_definition (name, data_type, symbol, description, sort_order, assessment_tool_id) VALUES ('Total number of assisted vaginal deliveries', 'Numeric', 'asstVagDel', 'This number will be derived from labour room register', 301, at_id);
  INSERT INTO indicator_definition (name, data_type, symbol, description, sort_order, assessment_tool_id) VALUES ('Total number of C-Sections', 'Numeric', 'cSectDel', 'This number will be derived from OT register', 302, at_id);
  INSERT INTO indicator_definition (name, data_type, formula, sort_order, assessment_tool_id) VALUES ('Total Number of Deliveries', 'Numeric', '(vagDel + asstVagDel + cSectDel)', 310, at_id);


  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Total number of maternal deaths', 'Numeric', 'Enumerate based on LR, OT and PNC Register', 400, at_id);


  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Causes of maternal death - APH', 'Numeric', 'FBMDR Register', 500, at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Causes of maternal death - PPH', 'Numeric', 'FBMDR Register', 501, at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Causes of maternal death - Sepsis', 'Numeric', 'FBMDR Register', 502, at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Causes of maternal death - Obstructed labour', 'Numeric', 'FBMDR Register', 503, at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Causes of maternal death - PIH/Eclampsia', 'Numeric', 'FBMDR Register', 504, at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Causes of maternal death - Others', 'Numeric', 'FBMDR Register', 505, at_id);


  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Total number of live births', 'Numeric', 'Total number of live births registered in last month as per the LR and OT register', 600, at_id);


  INSERT INTO indicator_definition (name, data_type, symbol, description, sort_order, assessment_tool_id) VALUES ('Total number of Fresh Still births', 'Numeric', 'frhStlBir', 'Total number of live births registered in last month as per the LR and OT register', 700, at_id);
  INSERT INTO indicator_definition (name, data_type, symbol, description, sort_order, assessment_tool_id) VALUES ('Total number of macerated still births', 'Numeric', 'macStlBir', 'Total number of live births registered in last month as per the LR and OT register', 701, at_id);
  INSERT INTO indicator_definition (name, data_type, formula, sort_order, assessment_tool_id) VALUES ('Total number of still births', 'Numeric', '(frhStlBir + macStlBir)', 702, at_id);


  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Number of neonatal deaths', 'Numeric', 'This number includes all inborn and out-born newborn - LR & SNCU Register', 800, at_id);


  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Major causes of neonatal deaths - Prematurity', 'Numeric', 'FBMDR Register', 900, at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Major causes of neonatal deaths - Sepsis', 'Numeric', 'FBMDR Register', 901, at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Major causes of neonatal deaths - Asphyxia', 'Numeric', 'FBMDR Register', 902, at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Major causes of neonatal deaths - Others', 'Numeric', 'FBMDR Register', 903, at_id);



  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Total number of Low Birth Weight babies born in facility', 'Numeric', 'LR Register', 1000, at_id);


  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Number of normal deliveries conducted in presence of Birth Companion', 'Numeric', 'LR Additional column on birth companion to be added in LR register to collect this indicator', 1100, at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Number of normal deliveries conducted using Safe Birth Checklist', 'Numeric', 'Additional column on safe birth checklist to be added in LR register to collect this indicator', 1200, at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Number of planned and emergency C-Section operations where safe surgical checklist was used', 'Numeric', 'Additional column on safe surgical checklist to be added in LR register to collect this indicator', 1300, at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Number of normal deliveries conducted using real time Partograph', 'Numeric', 'Real time Partograph column data for LR Register', 1400, at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Number of newborns delivered in facility who were breastfed within one hour of delivery', 'Numeric', 'Additional column on initiation of breastfeeding to be added in PNC register to collect this indicator', 1500, at_id);
  INSERT INTO indicator_definition (name, data_type, coded_values, description, sort_order, assessment_tool_id) VALUES ('Whether microbiological sampling from labour room is collected as per protocol', 'Coded', '["Yes", "No"]', 'New register for sampling in LR', 1600, at_id);
  INSERT INTO indicator_definition (name, data_type, coded_values, description, sort_order, assessment_tool_id) VALUES ('Whether microbiological sampling from Maternity OT  is collected as per protocol', 'Coded', '["Yes", "No"]', 'New register for sampling in OT', 1700, at_id);
  INSERT INTO indicator_definition (name, data_type, coded_values, description, sort_order, assessment_tool_id) VALUES ('Number of C-Sections operations in which surgical site infection developed within one month of operation', 'Coded', '["Yes", "No"]', 'Additional column on surgical site infection to be added in PNC and OPD register to collect this indicator', 1800, at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Number of preterm cases where Antenatal Corticosteroids (ANCS) was administered in facilities with SNCU', 'Numeric', 'Additional column on ANCS to be added in ANC register to collect this indicator (ANC Register/ LR Register)', 1900, at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Number of newborns delivered in facility with SNCU developed birth asphyxia', 'Numeric', 'SNCU register will provide number of inborn newborns developing birth asphyxia', 2000, at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Number of newborns delivered in facility with SNCU developed sepsis', 'Numeric', 'SNCU register will provide number of inborn newborns developing sepsis', 2100, at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Total number of inborn LBW newborns in facility provided KMC', 'Numeric', 'This includes all inborn LBW newborn in facility including LR & SNCU', 2200, at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Number of beneficiaries delivered last month who were either satisfied or highly satisfied', 'Numeric', 'Please mention how many women were interviewed and how many responded satisfied or highly satisfied (MeraAspatal App or Physical interview at facility)', 2300, at_id);
  INSERT INTO indicator_definition (name, data_type, coded_values, description, sort_order, assessment_tool_id) VALUES ('Whether facility has reorganized labour room as per the guidelines', 'Coded', '["Yes", "No", "In Progress"]', 'LR standard checklist', 2400, at_id);
  INSERT INTO indicator_definition (name, data_type, coded_values, description, sort_order, assessment_tool_id) VALUES ('Whether facility has adequate staff at labour rooms as per defined norms', 'Coded', '["Yes", "No"]', 'Annexure B of LaQshya Guidelines', 2500, at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Number of deliveries conducted in facility where Oxytocin was administered within one minute of birth', 'Numeric', 'AMTSL column in LR register will provide this data', 2600, at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Number of maternal deaths were reviewed in last month', 'Numeric', 'FBMCDR meeting minutes will provide this data', 2700, at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Number of neonatal deaths were reviewed in last month', 'Numeric', 'FBMCDR meeting minute', 2800, at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Number of Maternal Near Miss Cases were reviewed in last month', 'Numeric', 'FBMCDR meeting minutes will provide this data', 2900, at_id);
  INSERT INTO indicator_definition (name, data_type, coded_values, description, sort_order, assessment_tool_id) VALUES ('Whether there was any stock outs of drugs and consumables in LR', 'Coded', '["Yes", "No"]', 'Pharmacy Stock out register', 3000, at_id);
  INSERT INTO indicator_definition (name, data_type, coded_values, description, sort_order, assessment_tool_id) VALUES ('Whether there was any stock outs of drugs and consumables in maternity OT', 'Coded', '["Yes", "No"]', 'Pharmacy Stock out register', 3100, at_id);
  INSERT INTO indicator_definition (name, data_type, coded_values, description, sort_order, assessment_tool_id) VALUES ('Whether facility labour room has achieved NQAS certification', 'Coded', '["Yes", "No"]', 'NQAS assessment report', 3200, at_id);
  INSERT INTO indicator_definition (name, data_type, coded_values, description, sort_order, assessment_tool_id) VALUES ('Whether MCH/DH has functional Obs ICU/Hybrid ICU/HDU', 'Coded', '["Yes", "No", "In Progress"]', 'Obs ICU/HDU monthly report submitted by facility', 3300, at_id);

  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Number of LaQshya mentoring visits conducted', 'Numeric', 'Mention number of visits by mentors', 3400, at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Number of QI team meetings at labour room/OT', 'Numeric', 'Please mention number of meetings', 3500, at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Number of onsite training session conducted', 'Numeric', 'Please mention number of training session conducted', 3600, at_id);
END;
$$ LANGUAGE plpgsql; 


SELECT setup_laqshya_indicators();