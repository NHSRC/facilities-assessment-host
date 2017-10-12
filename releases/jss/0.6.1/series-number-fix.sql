UPDATE facility_assessment
SET series_name = '3'
WHERE id IN (SELECT facility_assessment.id
             FROM facility_assessment
               INNER JOIN assessment_tool ON facility_assessment.assessment_tool_id = assessment_tool.id AND assessment_tool.name = 'Dakshata'
               INNER JOIN facility ON facility_assessment.facility_id = facility.id AND facility.name IN ('CHC Pali', 'DH Anuppur', 'CHC Pushprajgarh') AND
                                      facility_assessment.series_name = '1');
UPDATE facility_assessment
SET series_name = '1'
WHERE id IN (SELECT facility_assessment.id
             FROM facility_assessment
               INNER JOIN assessment_tool ON facility_assessment.assessment_tool_id = assessment_tool.id AND assessment_tool.name = 'Dakshata'
               INNER JOIN facility ON facility_assessment.facility_id = facility.id AND facility.name IN ('CHC Pali', 'DH Anuppur', 'CHC Pushprajgarh') AND
                                      facility_assessment.series_name = '2');
UPDATE facility_assessment
SET series_name = '2'
WHERE id IN (SELECT facility_assessment.id
             FROM facility_assessment
               INNER JOIN assessment_tool ON facility_assessment.assessment_tool_id = assessment_tool.id AND assessment_tool.name = 'Dakshata'
               INNER JOIN facility ON facility_assessment.facility_id = facility.id AND facility.name IN ('CHC Pali', 'DH Anuppur', 'CHC Pushprajgarh') AND
                                      facility_assessment.series_name = '3');