-- VIEW A CHECKLIST WITH ALL THE CHECKPOINTS
SELECT
  a.id                                                               as assessment_tool_id,
  a.name                                                             as assessment_tool,
  c2.name                                                            AS Checklist,
  format('%s (%s)', area_of_concern.reference, area_of_concern.name) AS area_of_concern,
  standard.reference                                                 AS Standard,
  measurable_element.reference                                       AS MeasurableElementReference,
  measurable_element.name                                            AS MeasurableElement,
  checkpoint.id                                                      as checkpoint_id,
  checkpoint.name                                                    As Checkpoint,
  checkpoint.inactive                                                as inactive,
  checkpoint.last_modified_date                                      as last_modified_date
FROM checkpoint
  inner join measurable_element on checkpoint.measurable_element_id = measurable_element.id
  inner join standard on measurable_element.standard_id = standard.id
  inner join area_of_concern on standard.area_of_concern_id = area_of_concern.id
  inner join checklist_area_of_concern on area_of_concern.id = checklist_area_of_concern.area_of_concern_id
  inner join checklist c2 on checkpoint.checklist_id = c2.id
  inner join assessment_tool a on c2.assessment_tool_id = a.id
where c2.name = 'ANC OPD'
ORDER BY Checklist, area_of_concern, Standard, measurable_element.reference;

-- VIEW CHECKLISTS
SELECT
  state.name                State,
  assessment_tool_mode.name AssessmentToolMode,
  assessment_tool.name      AssessmentTool,
  cl.name                   Checklist,
  count(c.id) AS            NumCheckpoints
FROM checkpoint c
  INNER JOIN checklist cl ON c.checklist_id = cl.id
  INNER JOIN state ON (cl.state_id = state.id OR cl.state_id is NULL)
  INNER JOIN assessment_tool ON assessment_tool.id = cl.assessment_tool_id
  INNER JOIN assessment_tool_mode ON assessment_tool_mode.id = assessment_tool.assessment_tool_mode_id
where assessment_tool.name = 'Dakshata'
GROUP BY state.name, assessment_tool_mode.name, assessment_tool.name, cl.name
ORDER BY state.name, assessment_tool_mode.name, assessment_tool.name, cl.name;

select * from assessment_tool;
select * from checklist;

-- Assessment Tool + Checklist + AOC + Standard
SELECT
  c.name                                     AS Checklist,
  department.name                            AS department,
  format('%s (%s)', aoc.reference, aoc.name) AS area_of_concern,
  s.reference                                AS Standard,
  me.reference                               AS MeasurableElementReference,
  me.name                                    AS MeasurableElement,
  cp.name                                    As Checkpoint
FROM
  checklist c, area_of_concern aoc, checklist_area_of_concern caoc, standard s, measurable_element me, checkpoint cp, assessment_tool, assessment_tool_mode, department,
  state
WHERE caoc.checklist_id = c.id AND aoc.id = caoc.area_of_concern_id AND s.area_of_concern_id = aoc.id AND
      c.assessment_tool_id = assessment_tool.id AND assessment_tool_mode.id = assessment_tool.assessment_tool_mode_id
      AND c.department_id = department.id AND (state.id = c.state_id OR c.state_id is NULL) AND cp.checklist_id = c.id AND cp.measurable_element_id = me.id AND
      me.standard_id = s.id
      AND assessment_tool.name = 'Dakshata' and state.name = 'Chhattisgarh'
ORDER BY Checklist, area_of_concern, Standard, me.reference;


select checkpoint.id from checkpoint inner join measurable_element on checkpoint.measurable_element_id = measurable_element.id where measurable_element.reference = 'C1.5' and checkpoint.name = 'Availability of functional telephone and Intercom Services' and checkpoint.checklist_id = 93;

select * from checkpoint order by last_modified_date desc;