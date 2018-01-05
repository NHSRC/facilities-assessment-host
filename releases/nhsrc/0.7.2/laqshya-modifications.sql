DELETE FROM checkpoint
WHERE checklist_id IN (SELECT checklist.id
                       FROM checklist
                         INNER JOIN assessment_tool ON checklist.assessment_tool_id = assessment_tool.id
                         INNER JOIN assessment_tool_mode ON assessment_tool.assessment_tool_mode_id = assessment_tool_mode.id
                                                            AND assessment_tool_mode.name = 'LAQSHYA' AND checklist.name IN ('Form 2', 'Form 3'));

DELETE FROM measurable_element WHERE id NOT IN (SELECT measurable_element_id from checkpoint);
DELETE FROM standard WHERE id NOT in (SELECT standard_id from measurable_element);
DELETE from checklist_area_of_concern WHERE checklist_id IN (SELECT id from checklist WHERE name IN ('Form 2', 'Form 3'));
DELETE from area_of_concern WHERE id NOT in (SELECT area_of_concern_id from standard);

DELETE from checklist WHERE name in ('Form 2', 'Form 3');
DELETE from department WHERE name in ('Form 2', 'Form 3');

update assessment_tool SET name = 'OSCE' WHERE id = (SELECT id from assessment_tool WHERE name = 'Dakshata');
-- DELETE from checkpoint WHERE checklist_id = (SELECT id from checklist where );
