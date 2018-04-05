update checkpoint
set measurable_element_id = (select id from measurable_element where reference = 'C2.3' and standard_id = (select standard_id from measurable_element where reference = 'C2..3')),
  last_modified_date = current_timestamp
where measurable_element_id = (select id from measurable_element where reference = 'C2..3');
update checkpoint
set measurable_element_id = (select id from measurable_element where reference = 'C2.4' and standard_id = (select standard_id from measurable_element where reference = 'C2..4')),
  last_modified_date = current_timestamp
where measurable_element_id = (select id from measurable_element where reference = 'C2..4');

update measurable_element set inactive = true and last_modified_date = current_timestamp where reference = 'C2..3';
update measurable_element set inactive = true and last_modified_date = current_timestamp where reference = 'C2..4';