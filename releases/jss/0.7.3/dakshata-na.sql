UPDATE checkpoint set score_levels = 2, last_modified_date = current_timestamp WHERE id in
(SELECT c2.id from area_of_concern
  INNER JOIN standard s2 ON area_of_concern.id = s2.area_of_concern_id
  INNER JOIN measurable_element m2 ON s2.id = m2.standard_id
  INNER JOIN checkpoint c2 ON m2.id = c2.measurable_element_id
where area_of_concern.name = 'MNH Program (Practices)');

UPDATE checkpoint set is_optional = true, last_modified_date = current_timestamp WHERE id in
     (SELECT c2.id from area_of_concern
       INNER JOIN standard s2 ON area_of_concern.id = s2.area_of_concern_id
       INNER JOIN measurable_element m2 ON s2.id = m2.standard_id
       INNER JOIN checkpoint c2 ON m2.id = c2.measurable_element_id
     where area_of_concern.name in ('MNH Program (Practices)', 'Availability of resources'));