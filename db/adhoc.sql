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
FROM public.facility;

SELECT
  aocw.ref      AS "Area of Concern",
  aocw.aocscore AS "Score"
FROM
  (SELECT
     aoc.reference                                                                     AS ref,
     aoc.name                                                                          AS aocname,
     (sum(cs.score) :: FLOAT / (2 * count(cs.score) :: FLOAT) :: FLOAT * 100 :: FLOAT) AS aocscore,
     max(fa.start_date)
   FROM checkpoint_score cs
     INNER JOIN checkpoint c ON cs.checkpoint_id = c.id
     LEFT OUTER JOIN checklist cl ON cl.id = cs.checklist_id
     LEFT OUTER JOIN department ON cl.department_id = department.id
     LEFT OUTER JOIN measurable_element me ON me.id = c.measurable_element_id
     LEFT OUTER JOIN standard s ON s.id = me.standard_id
     LEFT OUTER JOIN area_of_concern aoc ON aoc.id = s.area_of_concern_id
     LEFT OUTER JOIN facility_assessment fa ON cs.facility_assessment_id = fa.id
     LEFT OUTER JOIN facility ON fa.facility_id = facility.id
   WHERE facility.name = 'Jan Swasthya Sahyog (JSS)'
   GROUP BY aoc.name, aoc.reference
   ORDER BY aoc.reference) AS aocw;

SET SEARCH_PATH = public;
SELECT count(*)
FROM checkpoint_score, facility_assessment, facility
WHERE checkpoint_score.facility_assessment_id = facility_assessment.id AND facility_assessment.facility_id = facility.id AND facility.name = 'Jan Swasthya Sahyog (JSS)';

SELECT
  series_name,
  facility_id
FROM facility_assessment
ORDER BY series_name, facility_id;
SELECT *
FROM facility;

UPDATE facility_assessment
SET last_modified_date = current_timestamp
WHERE series_name = '2';
UPDATE facility_assessment
SET series_name = '1', last_modified_date = current_timestamp
WHERE series_name IS NULL;

SELECT count(*)
FROM checkpoint_score
WHERE checklist_id = (SELECT id
                      FROM checklist
                      WHERE state_id = 2 AND name = 'SNCU') AND facility_assessment_id = (SELECT id
                                                                                          FROM facility_assessment
                                                                                          WHERE facility_id = (SELECT id
                                                                                                               FROM facility
                                                                                                               WHERE name = 'Mungeli District Hospital'));

SELECT *
FROM state;

SELECT
  Facility,
  Series,
  ChecklistName,
  CheckpointName,
  CheckpointId,
  Times
FROM
  (SELECT
     facility.name                            Facility,
     facility_assessment.id                   FacilityAssesmentId,
     facility_assessment.series_name          Series,
     checklist.id                             ChecklistId,
     checklist.name                           ChecklistName,
     checkpoint.id                            CheckpointId,
     checkpoint.name                          CheckpointName,
     count(checkpoint_score.checkpoint_id) AS Times
   FROM checkpoint, checkpoint_score, facility_assessment, facility, checklist
   WHERE
     checkpoint_score.checkpoint_id = checkpoint.id AND checkpoint_score.facility_assessment_id = facility_assessment.id AND facility_assessment.facility_id = facility.id
     AND checkpoint.checklist_id = checklist.id
   GROUP BY facility.id, facility_assessment.id, checklist.id, checkpoint.id) AS NumberOfTimesCheckpointFilled
WHERE Times > 1;

SELECT
  a.score,
  b.score,
  a.checkpoint_id,
  a.id
FROM checkpoint_score a, checkpoint_score b
WHERE a.checkpoint_id = b.checkpoint_id AND a.facility_assessment_id = b.facility_assessment_id AND a.score != b.score AND
      a.facility_assessment_id NOT IN (SELECT facility_assessment.id
                                       FROM facility_assessment, facility, state, district
                                       WHERE facility_assessment.facility_id = facility.id AND state.name = 'Madhya Pradesh' AND facility.district_id = district.id AND
                                             district.state_id = state.id)
ORDER BY a.checkpoint_id;

SELECT
  a.facility_assessment_id,
  a.checklist_id,
  a.checkpoint_id,
  a.id,
  a.last_modified_date
FROM checkpoint_score a, checkpoint_score b
WHERE a.checkpoint_id = b.checkpoint_id AND a.facility_assessment_id = b.facility_assessment_id AND a.checklist_id = b.checklist_id
      AND a.id != b.id
ORDER BY a.facility_assessment_id, a.checklist_id, a.checkpoint_id, a.last_modified_date;

SELECT *
FROM
  (SELECT
     Checkpoints.Facility            Facility,
     Checkpoints.Checklist           Checklist,
     count(Checkpoints.CheckpointId) UnfilledCheckpoints
   FROM
     (SELECT
        facility.name  Facility,
        checklist.name Checklist,
        checkpoint.id  CheckpointId
      FROM checkpoint, facility, facility_assessment, assessment_tool, checklist, state, district, assessment_tool_mode
      WHERE
        facility.id = facility_assessment.facility_id AND facility_assessment.assessment_tool_id = assessment_tool.id AND
        assessment_tool.id = checklist.assessment_tool_id
        AND checkpoint.checklist_id = checklist.id AND state.id = checklist.state_id AND facility.district_id = district.id AND district.state_id = state.id AND
        assessment_tool.assessment_tool_mode_id = assessment_tool_mode.id
        AND {{AssessmentMode}} AND facility_assessment.series_name = {{Series}} AND {{state}} [[AND {{facility}}]]) AS Checkpoints LEFT OUTER JOIN
     (SELECT
        checkpoint_score.checklist_id,
        checkpoint_score.checkpoint_id
      FROM checkpoint_score, facility, facility_assessment, assessment_tool, checklist, state, district, assessment_tool_mode
      WHERE
        facility.id = facility_assessment.facility_id AND facility_assessment.assessment_tool_id = assessment_tool.id AND
        assessment_tool.id = checklist.assessment_tool_id
        AND checkpoint_score.checklist_id = checklist.id AND checkpoint_score.facility_assessment_id = facility_assessment.id AND state.id = checklist.state_id AND
        facility.district_id = district.id AND district.state_id = state.id AND assessment_tool.assessment_tool_mode_id = assessment_tool_mode.id
        AND {{AssessmentMode}} AND facility_assessment.series_name = {{Series}} AND {{state}} [[AND {{facility}}]]) AS CheckpointScores
       ON Checkpoints.CheckpointId = CheckpointScores.checkpoint_id
   WHERE CheckpointScores.checkpoint_id IS NULL
   GROUP BY Checkpoints.Facility, Checkpoints.Checklist
   ORDER BY Checkpoints.Facility, Checkpoints.Checklist) AS UnfilledCheckpoints
WHERE UnfilledCheckpoints != (SELECT count(checkpoint.id)
                              FROM checkpoint, checklist, state
                              WHERE checkpoint.checklist_id = checklist.id AND checklist.state_id = state.id AND {{state}} AND checklist.name = Checklist);

----
UPDATE department set name = 'Blood Storage Unit' WHERE name = 'Blood storage unit';
UPDATE department set name = 'Auxillary Services' WHERE name = 'Auxillary services';
UPDATE department set name = 'Labour Room' WHERE name = 'Labour room';

UPDATE checklist AS c
SET department_id = foo.first_id
FROM (SELECT MIN (id) first_id, name FROM department GROUP BY NAME) AS foo
WHERE foo.name = (SELECT name from department WHERE c.department_id = department.id);

DELETE FROM department WHERE id not in (SELECT min(id) from department GROUP BY NAME);

UPDATE checklist SET department_id = (SELECT id from department WHERE  name = 'IPD') WHERE department_id = (SELECT id from department WHERE name = 'In Patient Department');
DELETE from department WHERE name = 'In Patient Department';
----

SELECT checklist.name checklist, department.name from checklist, department WHERE department_id = department.id ORDER BY checklist;

UPDATE checklist SET department_id = 19 WHERE department_id = 50;
UPDATE checklist SET department_id = 18 WHERE department_id in (45, 77);
UPDATE checklist SET department_id = 16 WHERE department_id in (24, 43, 60, 75);
UPDATE checklist SET department_id = 12 WHERE department_id in (12, 72);
UPDATE checklist SET department_id = 23 WHERE department_id in (23, 46, 59);
UPDATE checklist SET department_id = 1 WHERE department_id in (1, 29, 68);
UPDATE checklist SET department_id = 26 WHERE department_id in (26, 47);
UPDATE checklist SET department_id = 27 WHERE department_id in (27, 48);
UPDATE checklist SET department_id = 28 WHERE department_id in (28, 49);
UPDATE checklist SET department_id = 25 WHERE department_id in (25, 61);
UPDATE checklist SET department_id = 10 WHERE department_id in (10, 38, 70);
UPDATE checklist SET department_id = 11 WHERE department_id in (11, 39, 71, 53);
UPDATE checklist SET department_id = 13 WHERE department_id in (13, 40, 73);
UPDATE checklist SET department_id = 21 WHERE department_id in (21, 56);
UPDATE checklist SET department_id = 3 WHERE department_id in (3, 31, 52, 62);
UPDATE checklist SET department_id = 4 WHERE department_id in (4, 32, 63);
UPDATE checklist SET department_id = 17 WHERE department_id in (17, 44, 76);
UPDATE checklist SET department_id = 7 WHERE department_id in (7, 35, 66);
UPDATE checklist SET department_id = 7 WHERE department_id in (7, 35, 66);



SELECT id, name from department ORDER BY name;
SELECT DISTINCT name from department ORDER BY name;



SELECT count(*) foo from checklist;

SELECT DISTINCT department_id FROM checklist ORDER BY department_id;


-- where the there are multiple of checkpoint scores by deleting the old ones