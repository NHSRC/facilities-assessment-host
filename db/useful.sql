-- VIEW CHECKLISTS
SELECT
  state.name         State,
  assessment_tool_mode.name        AssessmentToolMode,
  assessment_tool.name        AssessmentTool,
  cl.name        Checklist,
  count(c.id) AS NumCheckpoints
FROM checkpoint c
  INNER JOIN checklist cl ON c.checklist_id = cl.id
  INNER JOIN state ON (cl.state_id = state.id OR cl.state_id is NULL)
  INNER JOIN assessment_tool ON assessment_tool.id = cl.assessment_tool_id
  INNER JOIN assessment_tool_mode ON assessment_tool_mode.id = assessment_tool.assessment_tool_mode_id
where state.name ='' and {{assessment_tool_mode}}]] [[and {{assessment_tool}}]]
GROUP BY state.name, assessment_tool_mode.name, assessment_tool.name, cl.name
ORDER BY state.name, assessment_tool_mode.name, assessment_tool.name, cl.name;

-- Assessment Tool + Checklist + AOC + Standard
SELECT
  c.name                 AS Checklist,
  department.name       AS department,
  format('%s (%s)', aoc.reference, aoc.name) AS area_of_concern,
  s.reference            AS Standard,
  me.reference AS MeasurableElementReference,
  me.name AS MeasurableElement,
  cp.name As Checkpoint
FROM checklist c, area_of_concern aoc, checklist_area_of_concern caoc, standard s, measurable_element me, checkpoint cp, assessment_tool, assessment_tool_mode, department, state
WHERE caoc.checklist_id = c.id AND aoc.id = caoc.area_of_concern_id AND s.area_of_concern_id = aoc.id AND
      c.assessment_tool_id = assessment_tool.id AND assessment_tool_mode.id = assessment_tool.assessment_tool_mode_id
      AND c.department_id = department.id AND (state.id = c.state_id OR c.state_id is NULL) AND cp.checklist_id = c.id AND cp.measurable_element_id = me.id AND me.standard_id = s.id
      AND {{assessment_mode}} AND {{state}}
ORDER BY Checklist, area_of_concern, Standard, me.reference;

