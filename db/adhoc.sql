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

SELECT *
FROM facility_assessment;
SELECT *
FROM facility;

SELECT
  f.id,
  at.id,
  fa.start_date,
  fa.end_date,
  fa.series_name,
  fa.id,
  fa.created_date,
  fa.last_modified_date
FROM mp.facility_assessment fa, public.assessment_tool at, mp.assessment_tool mpat, public.facility f
WHERE fa.assessment_tool_id = mpat.id AND mpat.name = at.name AND f.self_id = fa.facility_id;


SELECT
  x.Facility AS "Facility",
  x.Department AS "Department",
  x.Score      AS "Score"
FROM
  (SELECT
     dws.Facility AS Facility,
     dws.Department AS Department,
     dws.Score      AS Score
   FROM
     (SELECT
        facility.name AS Facility,
        d.name                                                                            AS Department,
        (sum(cs.score) :: FLOAT / (2 * count(cs.score) :: FLOAT) :: FLOAT * 100 :: FLOAT) AS Score,
        max(fa.start_date)
      FROM checkpoint_score cs
        INNER JOIN checkpoint c ON cs.checkpoint_id = c.id
        LEFT OUTER JOIN checklist cl ON cl.id = cs.checklist_id
        LEFT OUTER JOIN department d ON d.id = cl.department_id
        LEFT OUTER JOIN facility_assessment fa ON cs.facility_assessment_id = fa.id
        LEFT OUTER JOIN facility ON fa.facility_id = facility.id
        LEFT OUTER JOIN district ON district.id = facility.district_id
        LEFT OUTER JOIN state ON state.id = district.state_id
        LEFT OUTER JOIN facility_type ON facility_type.id = facility.facility_type_id
      WHERE {{type}} and {{state}}
     GROUP BY facility.name, d.name order by Score) AS dws
   ) as x