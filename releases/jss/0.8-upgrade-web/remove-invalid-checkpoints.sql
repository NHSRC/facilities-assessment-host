update checkpoint set measurable_element_id = (select id from measurable_element where reference = 'D3.3' and standard_id = (select standard_id from measurable_element where id = 421)) where measurable_element_id = 421;
update checkpoint set measurable_element_id = (select id from measurable_element where reference = 'D3.3' and standard_id = (select standard_id from measurable_element where id = 1426)) where measurable_element_id = 1426;
delete from measurable_element where reference = 'D3,3';

update checkpoint set measurable_element_id = (select id from measurable_element where reference = 'C6.7' and standard_id = (select standard_id from measurable_element where id = 97)) where measurable_element_id = 97;
update checkpoint set measurable_element_id = (select id from measurable_element where reference = 'C6.7' and standard_id = (select standard_id from measurable_element where id = 838)) where measurable_element_id = 838;
delete from measurable_element where reference = 'BC6.7';

update checkpoint set measurable_element_id = (select id from measurable_element where reference = 'C5.7' and standard_id = (select standard_id from measurable_element where id = 408)) where measurable_element_id = 408;
delete from measurable_element where reference = 'BC5.7';

update checkpoint set measurable_element_id = (select id from measurable_element where reference = 'G5.4' and standard_id = (select standard_id from measurable_element where id = 582)) where measurable_element_id = 582;
delete from measurable_element where reference = '5.4';