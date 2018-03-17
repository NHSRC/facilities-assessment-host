INSERT INTO assessment_tool (name, assessment_tool_mode_id) VALUES ('LAQSHYA Monthly', (SELECT id from assessment_tool_mode WHERE name = 'LAQSHYA'));
UPDATE assessment_tool SET type = 'INDICATOR' WHERE name = 'LAQSHYA Monthly';
INSERT INTO assessment_tool (name, assessment_tool_mode_id) VALUES ('LAQSHYA Baseline', (SELECT id from assessment_tool_mode WHERE name = 'LAQSHYA'));
UPDATE assessment_tool SET type = 'INDICATOR' WHERE name = 'LAQSHYA Baseline';


CREATE OR REPLACE FUNCTION setup_laqshya_indicators()
  RETURNS VOID AS $$
DECLARE monthly_at_id INT;
DECLARE baseline_at_id INT;
BEGIN
-- BASELINE
  SELECT id into baseline_at_id from assessment_tool WHERE name = 'LAQSHYA Baseline';
  INSERT INTO indicator_definition (name, data_type, coded_values, symbol, description, sort_order, assessment_tool_id) VALUES ('Facility has completed baseline assessment of labour room using NQAS checklist', 'Coded', '["Yes", "No"]', 'completedBaselineLR', 'NQAS Checklist', 100, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, sort_order, assessment_tool_id) VALUES ('Month of baseline assessment for labour room', 'Month', 200,  baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, symbol, description, sort_order, assessment_tool_id) VALUES ('Baseline Score for Labour Room', 'Percentage', NULL, 'Overall score using NQAS Labour Room Checklist for Laqshya', 300, baseline_at_id);

  INSERT INTO indicator_definition (name, data_type, coded_values, symbol, description, sort_order, assessment_tool_id) VALUES ('Facility has completed baseline assessment of Operation Theatre using NQAS checklist', 'Coded', '["Yes", "No"]', 'completedBaselineOT', 'NQAS Checklist', 400, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, sort_order, assessment_tool_id) VALUES ('Month of baseline assessment for Operation Theatre', 'Month', 500,  baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, symbol, description, sort_order, assessment_tool_id) VALUES ('Baseline Score for Operation Theatre', 'Percentage', NULL, 'Overall score using NQAS Operation Theatre Checklist for Laqshya', 600, baseline_at_id);

  INSERT INTO indicator_definition (name, data_type, coded_values, description, sort_order, assessment_tool_id) VALUES ('Facility has assessed baseline staff competence using the OSCE', 'Coded', '["Yes", "No"]', '', 700, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, sort_order, assessment_tool_id) VALUES ('Month of baseline assessment for staff competence', 'Month', 800,  baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, symbol, description, sort_order, assessment_tool_id) VALUES ('Baseline average OSCE Score', 'Percentage', NULL, 'Average of all Labour Room and OT staff interviewed - OSCE checklist', 900, baseline_at_id);

  INSERT INTO indicator_definition (name, data_type, coded_values, symbol, description, sort_order, assessment_tool_id) VALUES ('Facility has setup facility level quality team', 'Coded', '["Yes", "No"]', 'setupFacilityQualityTeam', 'Facility report', 1000, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, coded_values, symbol, description, sort_order, assessment_tool_id) VALUES ('Facility has setup functional quality circle in Labour Room', 'Coded', '["Yes", "No"]', 'setupFunctionalQualityCircleLR', 'Yes or No. To be conducted once only. Report yes in subsequent reports - Facility report', 1100, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, coded_values, symbol, description, sort_order, assessment_tool_id) VALUES ('Facility has setup functional quality circle in Maternity OT', 'Coded', '["Yes", "No"]', 'setupFunctionalQualityCircleMaternityOT', 'Yes or No. To be conducted once only. Report yes in subsequent reports - Facility report', 1200, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, coded_values, symbol, description, sort_order, assessment_tool_id) VALUES ('Facility staff of LR and OT quality circles have attended district level or facility level orientation on LR Protocols, QI processes and RMC', 'Coded', '["Yes", "No"]', 'qualityCirclesAttendedOrientation', 'Yes or No. District level or facility level orientation report. To be reported once only - District Orientation report', 1300, baseline_at_id);

-- BASELINE OUTPUT
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('Facility has assessed Labour Room and OT using NQAS checklist and reported Baseline Quality Scores', 'Coded', '(completedBaselineLR && completedBaselineOT)', true, 1400, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('Facility has setup Quality Team at facility level and Quality Circles in Labour Room & Maternity OTs', 'Coded', '(setupFacilityQualityTeam && setupFunctionalQualityCircleLR && setupFunctionalQualityCircleMaternityOT)', true, 1500, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('Facility has oriented the Labour room and Maternity OT staff on LR protocols, RMC & QI', 'Coded', '(qualityCirclesAttendedOrientation)', true, 1600, baseline_at_id);



  -- MONTHLY
  SELECT id into monthly_at_id from assessment_tool WHERE name = 'LAQSHYA Monthly';

  INSERT INTO indicator_definition (name, data_type, sort_order, assessment_tool_id) VALUES ('Reporting Month', 'Month', 100,  monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, sort_order, assessment_tool_id) VALUES ('Date of Visit', 'Date', 200, monthly_at_id);


  INSERT INTO indicator_definition (name, data_type, symbol, description, sort_order, assessment_tool_id) VALUES ('Total number of normal vaginal deliveries', 'Numeric', 'numberOfVaginalDeliveries', 'This number will be derived from labour room register', 300, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, symbol, description, sort_order, assessment_tool_id) VALUES ('Total number of assisted vaginal deliveries', 'Numeric', 'numberOfAssistedVaginalDeliveries', 'This number will be derived from labour room register', 301, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, symbol, description, sort_order, assessment_tool_id) VALUES ('Total number of C-Sections', 'Numeric', 'numberOfCSectionDeliveries', 'This number will be derived from OT register', 302, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, sort_order, assessment_tool_id) VALUES ('Total Number of Deliveries', 'Numeric', '(numberOfVaginalDeliveries + numberOfAssistedVaginalDeliveries + numberOfCSectionDeliveries)', 310, monthly_at_id);


  INSERT INTO indicator_definition (name, data_type, description, symbol, sort_order, assessment_tool_id) VALUES ('Total number of maternal deaths', 'Numeric', 'Enumerate based on LR, OT and PNC Register', 'numberOfMaternalDeaths', 400, monthly_at_id);


  INSERT INTO indicator_definition (name, data_type, description, symbol, sort_order, assessment_tool_id) VALUES ('Causes of maternal death - APH', 'Numeric', 'FBMDR Register', 'numberOfAPHMaternalDeaths', 500, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, symbol, sort_order, assessment_tool_id) VALUES ('Causes of maternal death - PPH', 'Numeric', 'FBMDR Register', 'numberOfPPHMaternalDeaths', 501, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Causes of maternal death - Sepsis', 'Numeric', 'FBMDR Register', 502, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Causes of maternal death - Obstructed labour', 'Numeric', 'FBMDR Register', 503, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, symbol, sort_order, assessment_tool_id) VALUES ('Causes of maternal death - PIH/Eclampsia', 'Numeric', 'FBMDR Register', 'numberOfMaternalDeathsForPIHEclampsia', 504, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Causes of maternal death - Others', 'Numeric', 'FBMDR Register', 505, monthly_at_id);


  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Total number of live births', 'Numeric', 'Total number of live births registered in last month as per the LR and OT register', 600, monthly_at_id);


  INSERT INTO indicator_definition (name, data_type, symbol, description, sort_order, assessment_tool_id) VALUES ('Total number of Fresh Still births', 'Numeric', 'numberOfStillBirths', 'Total number of live births registered in last month as per the LR and OT register', 700, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, symbol, description, sort_order, assessment_tool_id) VALUES ('Total number of macerated still births', 'Numeric', 'numberOfMaceratedStillBirths', 'Total number of live births registered in last month as per the LR and OT register', 701, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, sort_order, assessment_tool_id) VALUES ('Total number of still births', 'Numeric', '(numberOfStillBirths + numberOfMaceratedStillBirths)', 702, monthly_at_id);


  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Number of neonatal deaths', 'Numeric', 'This number includes all inborn and out-born newborn - LR & SNCU Register', 800, monthly_at_id);


  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Major causes of neonatal deaths - Prematurity', 'Numeric', 'FBMDR Register', 900, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Major causes of neonatal deaths - Sepsis', 'Numeric', 'FBMDR Register', 901, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Major causes of neonatal deaths - Asphyxia', 'Numeric', 'FBMDR Register', 902, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Major causes of neonatal deaths - Others', 'Numeric', 'FBMDR Register', 903, monthly_at_id);



  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Total number of Low Birth Weight babies born in facility', 'Numeric', 'LR Register', 1000, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, symbol, sort_order, assessment_tool_id) VALUES ('Total number of Preterm Deliveries', 'Numeric', '', 'numberOfPretermDeliveries', 1050, monthly_at_id);


  INSERT INTO indicator_definition (name, data_type, description, symbol, sort_order, assessment_tool_id) VALUES ('Number of normal deliveries conducted in presence of Birth Companion', 'Numeric', 'LR Additional column on birth companion to be added in LR register to collect this indicator', 'numberOfNormalDeliveriesInPresenceOfBirthCompanion', 1100, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, symbol, sort_order, assessment_tool_id) VALUES ('Number of normal deliveries conducted using Safe Birth Checklist', 'Numeric', 'Additional column on safe birth checklist to be added in LR register to collect this indicator', 'numberOfNormalDeliveriesUsingSafeBirthChecklist', 1200, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, symbol, sort_order, assessment_tool_id) VALUES ('Number of planned and emergency C-Section operations where safe surgical checklist was used', 'Numeric', 'Additional column on safe surgical checklist to be added in LR register to collect this indicator', 'numberOfPlannedAndEmergencyCSections', 1300, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, symbol, sort_order, assessment_tool_id) VALUES ('Number of normal deliveries conducted using real time Partograph', 'Numeric', 'Real time Partograph column data for LR Register', 'numberOfNormalDeliveriesUsingPartograph', 1400, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, symbol, sort_order, assessment_tool_id) VALUES ('Number of newborns delivered in facility who were breastfed within one hour of delivery', 'Numeric', 'Additional column on initiation of breastfeeding to be added in PNC register to collect this indicator', 'numberOfNewbornsBreastfedWithinOneHour', 1500, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, coded_values, description, symbol, sort_order, assessment_tool_id) VALUES ('Whether microbiological sampling from labour room is collected as per protocol', 'Coded', '["Yes", "No"]', 'New register for sampling in LR', 'microbioLRSampleCollectedAsPerProtocol', 1600, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, coded_values, description, symbol, sort_order, assessment_tool_id) VALUES ('Whether microbiological sampling from Maternity OT is collected as per protocol', 'Coded', '["Yes", "No"]', 'New register for sampling in OT', 'microbioOTSampleCollectedAsPerProtocol', 1700, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, coded_values, symbol, description, sort_order, assessment_tool_id) VALUES ('Number of C-Sections operations in which surgical site infection developed within one month of operation', 'Coded', '["Yes", "No"]', 'Additional column on surgical site infection to be added in PNC and OPD register to collect this indicator', 'numberOfCSectionsWithSurgicalSiteInfection', 1800, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, symbol, sort_order, assessment_tool_id) VALUES ('Number of preterm cases where Antenatal Corticosteroids (ANCS) was administered in facilities with SNCU', 'Numeric', 'Additional column on ANCS to be added in ANC register to collect this indicator (ANC Register/ LR Register)', 'numberOfPretermAdministeredANCS', 1900, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, symbol, sort_order, assessment_tool_id) VALUES ('Number of newborns delivered in facility with SNCU developed birth asphyxia', 'Numeric', 'SNCU register will provide number of inborn newborns developing birth asphyxia', 'numberOfNewbornsDevelopedAsphyxia', 2000, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, symbol, sort_order, assessment_tool_id) VALUES ('Number of newborns delivered in facility with SNCU developed sepsis', 'Numeric', 'SNCU register will provide number of inborn newborns developing sepsis', 'numberOfNewbornsDevelopedSepsis', 2100, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Total number of inborn LBW newborns in facility provided KMC', 'Numeric', 'This includes all inborn LBW newborn in facility including LR & SNCU', 2200, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, symbol, sort_order, assessment_tool_id) VALUES ('Number of beneficiaries delivered last month who were either satisfied or highly satisfied', 'Numeric', 'Please mention how many women were interviewed and how many responded satisfied or highly satisfied (MeraAspatal App or Physical interview at facility)', 'numberOfBeneficiariesSatisfied', 2300, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, coded_values, description, symbol, sort_order, assessment_tool_id) VALUES ('Whether facility has reorganized labour room as per the guidelines', 'Coded', '["Yes", "No", "In Progress"]', 'LR standard checklist', 'facilityHasReorganizedLR', 2400, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, coded_values, description, symbol, sort_order, assessment_tool_id) VALUES ('Whether facility has adequate staff at labour rooms as per defined norms', 'Coded', '["Yes", "No"]', 'Annexure B of LaQshya Guidelines', 'facilityHasAdequateStaffAtLR', 2500, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, symbol, sort_order, assessment_tool_id) VALUES ('Number of deliveries conducted in facility where Oxytocin was administered within one minute of birth', 'Numeric', 'AMTSL column in LR register will provide this data', 'numberOfDeliveriesWithOxytocinAdministered', 2600, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, symbol, sort_order, assessment_tool_id) VALUES ('Number of maternal deaths were reviewed in last month', 'Numeric', 'FBMCDR meeting minutes will provide this data', 'numberOfMaternalDeathsReviewed', 2700, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, symbol, sort_order, assessment_tool_id) VALUES ('Number of neonatal deaths were reviewed in last month', 'Numeric', 'FBMCDR meeting minute', 'numberOfNeonatalDeathsReviewed', 2800, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, symbol, sort_order, assessment_tool_id) VALUES ('Number of Maternal Near Miss Cases were reviewed in last month', 'Numeric', 'FBMCDR meeting minutes will provide this data', 'numberOfMaternalNearMissCases', 2900, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, symbol, sort_order, assessment_tool_id) VALUES ('Number of Referral cases reviewed in the month', 'Numeric', '', 'numberOfReferralCasesReviewed', 2950, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, coded_values, description, sort_order, assessment_tool_id) VALUES ('Whether there was any stock outs of drugs and consumables in LR', 'Coded', '["Yes", "No"]', 'Pharmacy Stock out register', 3000, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, coded_values, description, symbol, sort_order, assessment_tool_id) VALUES ('Whether there was any stock outs of drugs and consumables in maternity OT', 'Coded', '["Yes", "No"]', 'Pharmacy Stock out register', 'anyStockoutsOfDrugsAndConsumablesInMaternityOT', 3100, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, coded_values, description, sort_order, assessment_tool_id) VALUES ('Whether facility labour room has achieved NQAS certification', 'Coded', '["Yes", "No"]', 'NQAS assessment report', 3200, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, coded_values, description, symbol, sort_order, assessment_tool_id) VALUES ('Whether MCH/DH has functional Obs ICU/Hybrid ICU/HDU', 'Coded', '["Yes", "No", "In Progress"]', 'Obs ICU/HDU monthly report submitted by facility', 'hasFunctionalObsICUHDU', 3300, monthly_at_id);

  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Number of LaQshya mentoring visits conducted', 'Numeric', 'Mention number of visits by mentors', 3400, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Number of QI team meetings at labour room/OT', 'Numeric', 'Please mention number of meetings', 3500, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Number of onsite training session conducted', 'Numeric', 'Please mention number of training session conducted', 3600, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Current Labour Room Quality Score', 'Percentage', 'Overall score using NQAS Labour Room Checklist for Laqshya - NQAS Checklist', 3700, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, sort_order, assessment_tool_id) VALUES ('Current Maternity OT Quality Score', 'Percentage', 'Overall score using NQAS Maternity OT Checklist for Laqshya - NQAS Checklist', 3800, monthly_at_id);
  INSERT INTO indicator_definition (name, data_type, description, symbol, sort_order, assessment_tool_id) VALUES ('Current OSCE Score', 'Percentage', 'Average of all Labour Room and OT staff interviewed - OSCE checklist', 'cuurentOSCEScore', 3900, monthly_at_id);

-- MONTHLY OUTPUT
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('Percentage of deliveries are attended by a birth companion', 'Percentage', '((numberOfNormalDeliveriesUsingSafeBirthChecklist*100)/(numberOfVaginalDeliveries+numberOfAssistedVaginalDeliveries))', true, 10100, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('Percentage deliveries are conducted using safe birth checklist in Labour Room', 'Percentage', '((numberOfNormalDeliveriesUsingSafeBirthChecklist*100)/(numberOfVaginalDeliveries+numberOfAssistedVaginalDeliveries))', true, 10200, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('Percentage of deliveries are conducted using  Safe Surgery checklist in Maternity OT', 'Percentage', '((numberOfNormalDeliveriesUsingSafeBirthChecklist*100)/(numberOfVaginalDeliveries+numberOfAssistedVaginalDeliveries))', true, 10300, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('Percentage of deliveries for which Partograph is generated using real-time information in at least', 'Percentage', '((numberOfNormalDeliveriesUsingSafeBirthChecklist*100)/(numberOfVaginalDeliveries+numberOfAssistedVaginalDeliveries))', true, 10400, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('Percentage breastfeeding within 1 hour', 'Percentage', '((numberOfNewbornsBreastfedWithinOneHour*100)/(numberOfVaginalDeliveries+numberOfAssistedVaginalDeliveries+numberOfCSectionDeliveries))', true, 10500, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('Neonatal asphyxia rate in Inborn Babies ', 'Percentage', '((numberOfNewbornsDevelopedAsphyxia*100)/(numberOfVaginalDeliveries+numberOfAssistedVaginalDeliveries+numberOfCSectionDeliveries))', true, 10600, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('Neonatal sepsis rate in-born babies', 'Percentage', '((numberOfNewbornsDevelopedSepsis*100)/(numberOfVaginalDeliveries+numberOfAssistedVaginalDeliveries+numberOfCSectionDeliveries))', true, 10700, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('Surgical Site infection Rate in Maternity OT', 'Percentage', '((numberOfCSectionsWithSurgicalSiteInfection*100)/(numberOfCSectionDeliveries))', true, 10800, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('Antenatal corticosteroid administration rate in case in preterm labour', 'Percentage', '((numberOfPretermAdministeredANCS*100)/(numberOfPretermDeliveries))', true, 10900, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('Pre-eclampsia, eclampsia & PIH related mortality', 'Percentage', '((numberOfMaternalDeathsForPIHEclampsia*100)/(numberOfMaternalDeaths))', true, 11000, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('APH/PPH related mortality', 'Percentage', '((numberOfAPHMaternalDeaths + numberOfPPHMaternalDeaths)*100)/(numberOfMaternalDeaths))', true, 11100, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('Facility Labour Room is reorganized as labour room standardization guidelines', 'Coded', '(facilityHasReorganizedLR)', true, 11200, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('Facility Labour room has staffing as per defined norms', 'Coded', '(facilityHasAdequateStaffAtLR)', true, 11300, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('Percentage of Women, administered Oxytocin, immediately after birth', 'Percentage', '((numberOfDeliveriesWithOxytocinAdministered*100)/(numberOfAssistedVaginalDeliveries+numberOfVaginalDeliveries))', true, 11400, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('OSCE Score', 'Percentage', '(cuurentOSCEScore)', true, 11500, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('Facility conducts referral audit on Monthly basis', 'Coded', '(numberOfReferralCasesReviewed)', true, 11600, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('Facility conducts Maternal death, Neonatal death and near-miss on monthly basis', 'Numeric', '(numberOfNeonatalDeathsReviewed + numberOfMaternalDeathsReviewed + numberOfMaternalNearMissCases)', true, 11700, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('Facility report zero stock outs in Labour Room & Maternity OT', 'Coded', '(anyStockoutsOfDrugsAndConsumablesInMaternityOT)', true, 11800, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('Still Birth Rate', 'Percentage', '((numberOfMaceratedStillBirths + numberOfStillBirths)*100/(numberOfVaginalDeliveries+numberOfAssistedVaginalDeliveries+numberOfCSectionDeliveries))', true, 11900, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('Percentage of beneficiaries  who were either satisfied or highly satisfied', 'Percentage', '((numberOfBeneficiariesSatisfied)*100/(numberOfVaginalDeliveries+numberOfAssistedVaginalDeliveries+numberOfCSectionDeliveries))', true, 12000, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('Functional Obs ICU/Hybrid ICU/HDU', 'Coded', '(hasFunctionalObsICUHDU)', true, 12100, baseline_at_id);
  INSERT INTO indicator_definition (name, data_type, formula, output, sort_order, assessment_tool_id) VALUES ('Microbiological Surveillance in OT & LR', 'Coded', '(microbioOTSampleCollectedAsPerProtocol && microbioLRSampleCollectedAsPerProtocol)', true, 12200, baseline_at_id);
END;
$$ LANGUAGE plpgsql; 


SELECT setup_laqshya_indicators();