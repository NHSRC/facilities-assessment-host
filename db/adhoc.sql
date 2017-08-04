SELECT count(checkpoint.id)
FROM checkpoint, facility, facility_assessment, assessment_tool, checklist
WHERE
  facility.id = facility_assessment.facility_id AND facility_assessment.assessment_tool_id = assessment_tool.id AND assessment_tool.id = checklist.assessment_tool_id AND
  checkpoint.checklist_id = checklist.id AND facility.id = 3;

SELECT count(checkpoint_score.checkpoint_id)
FROM checkpoint_score, facility, facility_assessment, assessment_tool, checklist
WHERE
  facility.id = facility_assessment.facility_id AND facility_assessment.assessment_tool_id = assessment_tool.id AND assessment_tool.id = checklist.assessment_tool_id AND
  checkpoint_score.checklist_id = checklist.id AND checkpoint_score.facility_assessment_id = facility_assessment.id AND facility.id = 3;

SELECT count(*)
FROM checkpoint_score
WHERE facility_assessment_id = 4;

SELECT *
FROM facility_assessment;

-- FOR METABASE
SELECT
  Checkpoints.State,
  Checkpoints.Facility,
  Checkpoints.Checklist,
  count(Checkpoints.CheckpointId) Unfilled
FROM
  (SELECT
     state.name State,
     facility.name  Facility,
     checklist.name Checklist,
     checkpoint.id  CheckpointId
   FROM checkpoint, facility, facility_assessment, assessment_tool, checklist, state
   WHERE
     facility.id = facility_assessment.facility_id AND facility_assessment.assessment_tool_id = assessment_tool.id AND assessment_tool.id = checklist.assessment_tool_id
     AND checkpoint.checklist_id = checklist.id AND state.id = checklist.state_id) AS Checkpoints LEFT OUTER JOIN
  (SELECT
     checkpoint_score.checklist_id,
     checkpoint_score.checkpoint_id
   FROM checkpoint_score, facility, facility_assessment, assessment_tool, checklist, state
   WHERE
     facility.id = facility_assessment.facility_id AND facility_assessment.assessment_tool_id = assessment_tool.id AND assessment_tool.id = checklist.assessment_tool_id
     AND checkpoint_score.checklist_id = checklist.id AND checkpoint_score.facility_assessment_id = facility_assessment.id AND state.id = checklist.state_id AND
     state.id = 1) AS CheckpointScores
    ON Checkpoints.CheckpointId = CheckpointScores.checkpoint_id
WHERE CheckpointScores.checkpoint_id IS NULL
GROUP BY Checkpoints.State, Checkpoints.Facility, Checkpoints.Checklist ORDER BY Checkpoints.State, Checkpoints.Facility, Checkpoints.Checklist;