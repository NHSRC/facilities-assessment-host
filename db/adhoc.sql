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

----
UPDATE department
SET name = 'Blood Storage Unit'
WHERE name = 'Blood storage unit';
UPDATE department
SET name = 'Auxillary Services'
WHERE name = 'Auxillary services';
UPDATE department
SET name = 'Labour Room'
WHERE name = 'Labour room';

UPDATE checklist AS c
SET department_id = foo.first_id
FROM (SELECT
        MIN(id) first_id,
        name
      FROM department
      GROUP BY NAME) AS foo
WHERE foo.name = (SELECT name
                  FROM department
                  WHERE c.department_id = department.id);

DELETE FROM department
WHERE id NOT IN (SELECT min(id)
                 FROM department
                 GROUP BY NAME);

UPDATE checklist
SET department_id = (SELECT id
                     FROM department
                     WHERE name = 'IPD')
WHERE department_id = (SELECT id
                       FROM department
                       WHERE name = 'In Patient Department');
DELETE FROM department
WHERE name = 'In Patient Department';
----

SELECT
  checklist.name checklist,
  department.name
FROM checklist, department
WHERE department_id = department.id
ORDER BY checklist;

UPDATE checklist
SET department_id = 19
WHERE department_id = 50;
UPDATE checklist
SET department_id = 18
WHERE department_id IN (45, 77);
UPDATE checklist
SET department_id = 16
WHERE department_id IN (24, 43, 60, 75);
UPDATE checklist
SET department_id = 12
WHERE department_id IN (12, 72);
UPDATE checklist
SET department_id = 23
WHERE department_id IN (23, 46, 59);
UPDATE checklist
SET department_id = 1
WHERE department_id IN (1, 29, 68);
UPDATE checklist
SET department_id = 26
WHERE department_id IN (26, 47);
UPDATE checklist
SET department_id = 27
WHERE department_id IN (27, 48);
UPDATE checklist
SET department_id = 28
WHERE department_id IN (28, 49);
UPDATE checklist
SET department_id = 25
WHERE department_id IN (25, 61);
UPDATE checklist
SET department_id = 10
WHERE department_id IN (10, 38, 70);
UPDATE checklist
SET department_id = 11
WHERE department_id IN (11, 39, 71, 53);
UPDATE checklist
SET department_id = 13
WHERE department_id IN (13, 40, 73);
UPDATE checklist
SET department_id = 21
WHERE department_id IN (21, 56);
UPDATE checklist
SET department_id = 3
WHERE department_id IN (3, 31, 52, 62);
UPDATE checklist
SET department_id = 4
WHERE department_id IN (4, 32, 63);
UPDATE checklist
SET department_id = 17
WHERE department_id IN (17, 44, 76);
UPDATE checklist
SET department_id = 7
WHERE department_id IN (7, 35, 66);
UPDATE checklist
SET department_id = 7
WHERE department_id IN (7, 35, 66);


SELECT
  id,
  name
FROM department
ORDER BY name;
SELECT DISTINCT name
FROM department
ORDER BY name;

SELECT
  id,
  name
FROM assessment_tool
WHERE assessment_tool_mode_id = 3;

SELECT *
FROM checkpoint_score
WHERE checkpoint_score.checklist_id = (SELECT id
                                       FROM checklist
                                       WHERE name = 'Laboratory' AND assessment_tool_id = 1 AND state_id = 1) AND facility_assessment_id = 49;
SELECT *
FROM checkpoint_score
WHERE facility_assessment_id = 46;


SELECT
  id,
  series_name
FROM facility_assessment
ORDER BY id;
UPDATE facility_assessment
SET last_modified_date = current_timestamp
WHERE id = 47;
SELECT *
FROM assessment_tool;
SELECT *
FROM state;
SELECT DISTINCT checklist.name
FROM checklist
ORDER BY checklist.name;

SELECT DISTINCT checkpoint_score.checkpoint_id
FROM checkpoint_score
WHERE facility_assessment_id = 49
ORDER BY checkpoint_id;
SELECT DISTINCT checkpoint_score.checkpoint_id
FROM checkpoint_score
WHERE facility_assessment_id = 52
ORDER BY checkpoint_id;

SELECT DISTINCT checklist_id
FROM checkpoint_score
WHERE facility_assessment_id = 47
ORDER BY checklist_id;
SELECT DISTINCT checklist_id
FROM checkpoint_score
WHERE facility_assessment_id = 46
ORDER BY checklist_id;
SELECT DISTINCT checklist_id
FROM checkpoint_score
WHERE facility_assessment_id = 49
ORDER BY checklist_id;
SELECT DISTINCT checklist_id
FROM checkpoint_score
WHERE facility_assessment_id = 50
ORDER BY checklist_id;
SELECT DISTINCT checklist_id
FROM checkpoint_score
WHERE facility_assessment_id = 52
ORDER BY checklist_id;

SELECT checkpoint.checklist_id
FROM checkpoint
WHERE id = 420;

SELECT *
FROM checkpoint_score
WHERE facility_assessment_id IN (46, 47, 49, 50, 52) AND checkpoint_id = 420;

UPDATE checkpoint_score
SET facility_assessment_id = 46
WHERE facility_assessment_id IN (47, 49, 50, 52);

SELECT
  facility_assessment_id,
  checklist_id,
  count(*)
FROM checkpoint_score
WHERE facility_assessment_id IN (49, 52)
GROUP BY checklist_id, facility_assessment_id;

SELECT *
FROM checkpoint_score
WHERE checklist_id = 16 AND facility_assessment_id = 49 AND checkpoint_id NOT IN (SELECT checkpoint_id
                                                                                  FROM checkpoint_score
                                                                                  WHERE facility_assessment_id = 52 AND checklist_id = 16);

SELECT
  id,
  state_id,
  name
FROM checklist
ORDER BY state_id, name;
SELECT *
FROM checkpoint
WHERE checklist_id = 85;


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
      FROM checkpoint, facility, facility_assessment, assessment_tool, checklist, area_of_concern, state, district, assessment_tool_mode
      WHERE
        facility.id = facility_assessment.facility_id AND facility_assessment.assessment_tool_id = assessment_tool.id AND
        assessment_tool.id = checklist.assessment_tool_id
        AND checkpoint.checklist_id = checklist.id AND (state.id = checklist.state_id OR checklist.state_id IS NULL) AND facility.district_id = district.id AND
        district.state_id = state.id AND assessment_tool.assessment_tool_mode_id = assessment_tool_mode.id AND assessment_tool_mode.name = 'dakshata' AND
        state.name = 'Madhya Pradesh') AS Checkpoints LEFT OUTER JOIN
     (SELECT
        checkpoint_score.checklist_id,
        checkpoint_score.checkpoint_id
      FROM checkpoint_score, facility, facility_assessment, assessment_tool, checklist, state, district, assessment_tool_mode
      WHERE
        facility.id = facility_assessment.facility_id AND facility_assessment.assessment_tool_id = assessment_tool.id AND
        assessment_tool.id = checklist.assessment_tool_id
        AND checkpoint_score.checklist_id = checklist.id AND checkpoint_score.facility_assessment_id = facility_assessment.id AND
        (state.id = checklist.state_id OR checklist.state_id IS NULL) AND facility.district_id = district.id AND district.state_id = state.id AND
        assessment_tool.assessment_tool_mode_id = assessment_tool_mode.id AND assessment_tool_mode.name = 'dakshata' AND
        state.name = 'Madhya Pradesh') AS CheckpointScores
       ON Checkpoints.CheckpointId = CheckpointScores.checkpoint_id
   WHERE CheckpointScores.checkpoint_id IS NULL
   GROUP BY Checkpoints.Facility, Checkpoints.Checklist
   ORDER BY Checkpoints.Facility, Checkpoints.Checklist) AS UnfilledCheckpoints
WHERE UnfilledCheckpoints != (SELECT count(checkpoint.id)
                              FROM checkpoint, checklist, state
                              WHERE checkpoint.checklist_id = checklist.id AND checklist.state_id = state.id AND state.name = 'Madhya Pradesh' AND
                                    checklist.name = Checklist);

SELECT name from department ORDER BY name;
SELECT name from checklist ORDER BY name;

SELECT DISTINCT name from checkpoint WHERE checklist_id in (SELECT id FROM checklist WHERE name = 'General');


SELECT * from checkpoint_score WHERE na = true;
SELECT DISTINCT score_levels from checkpoint;

SELECT * from assessment_type;

SELECT * from checkpoint WHERE is_optional = true;



SELECT
  state.id                state_id,
  assessment_tool_mode.name assessment_tool_mode_id,
  assessment_tool.name      assessment_tool_id,
  checklist.name            checklist_id,
  area_of_concern.name      area_of_concern_id,
  standard.name             standard_id,
  measurable_element.name   measurable_element_id,
  checkpoint.name           checkpoint_id
FROM checkpoint
  INNER JOIN measurable_element ON checkpoint.measurable_element_id = measurable_element.id
  INNER JOIN standard ON measurable_element.standard_id = standard.id
  INNER JOIN area_of_concern ON standard.area_of_concern_id = area_of_concern.id
  INNER JOIN checklist ON checkpoint.checklist_id = checklist.id
  INNER JOIN assessment_tool ON checklist.assessment_tool_id = assessment_tool.id
  INNER JOIN assessment_tool_mode ON assessment_tool.assessment_tool_mode_id = assessment_tool_mode.id
  INNER JOIN state ON (checklist.state_id = state.id OR checklist.state_id IS NULL)
WHERE is_optional = true;

SELECT DISTINCT means_of_verification from checkpoint limit 1;
SELECT * from checkpoint limit 100;


select * FROM checkpoint order by id desc;

SELECT * from facility;





SELECT
  aocw.aocname  AS "Area of Concern",
  aocw.aocscore AS "Score"
FROM
  (SELECT
     format('%s (%s)', aoc.reference, aoc.name) AS aocname,
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
     LEFT OUTER JOIN assessment_tool ON fa.assessment_tool_id = assessment_tool.id
     LEFT OUTER JOIN assessment_tool_mode ON assessment_tool_mode.id = assessment_tool.assessment_tool_mode_id
   WHERE facility.name = 'CHC Kota' and fa.series_name = '1' and assessment_tool_mode.name = 'nqas'
                                                                                                         GROUP BY aocname order by aocname) AS aocw;