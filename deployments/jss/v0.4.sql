-- FIX CG DATABASE
UPDATE public.checklist SET state_id = (SELECT id from state WHERE state.name = 'Chhattisgarh');

-- FIX JSS DATABASE
set search_path to mp;
INSERT INTO state (name) VALUES ('JSS');
INSERT INTO district (name, state_id) VALUES ('JSS', (SELECT id from state WHERE name = 'JSS'));
UPDATE facility SET district_id = (SELECT id from district WHERE district.name = 'JSS');
DELETE from district WHERE name = 'Bilaspur';
DELETE from state WHERE name = 'Chhattisgarh';

UPDATE checklist SET state_id = (SELECT id from state WHERE state.name = 'JSS');

--- MOVE MP TABLE DATA TO SINGLE DATABASE
ALTER TABLE public.state ADD COLUMN self_id INT DEFAULT 0;
INSERT INTO public.state (name, self_id) SELECT name, id from mp.state;

ALTER TABLE public.district ADD COLUMN self_id INT DEFAULT 0;
INSERT INTO public.district (name, state_id, self_id) SELECT d.name, s.id, d.id from mp.district d, public.state s WHERE d.state_id = s.self_id;

ALTER TABLE public.facility ADD COLUMN self_id INT DEFAULT 0;
INSERT INTO public.facility (name, district_id, facility_type_id) SELECT f.name, d.id, f.facility_type_id from mp.facility f, public.district d WHERE f.district_id = d.self_id;

ALTER TABLE public.department ADD COLUMN self_id INT DEFAULT 0;
INSERT INTO public.department (name, self_id, sort_order) SELECT d.name, d.id, d.sort_order from mp.department d;

ALTER TABLE public.checklist ADD COLUMN self_id INT DEFAULT 0;
INSERT INTO public.checklist (name, department_id, assessment_tool_id, self_id, state_id) SELECT cl.name, d.id, at.id, cl.id, s.id from mp.checklist cl, public.department d, public.assessment_tool at, mp.assessment_tool mpat, public.state s WHERE cl.assessment_tool_id = mpat.id AND mpat.name = at.name AND cl.department_id = d.self_id and cl.state_id = s.self_id;

ALTER TABLE public.area_of_concern ADD COLUMN self_id INT DEFAULT 0;
INSERT INTO public.area_of_concern (name, reference, assessment_tool_id, self_id) SELECT aoc.name, aoc.reference, at.id, aoc.id from mp.area_of_concern aoc, public.assessment_tool at, mp.assessment_tool mpat WHERE aoc.assessment_tool_id = mpat.id AND mpat.name = at.name;

ALTER TABLE public.standard ADD COLUMN self_id INT DEFAULT 0;
INSERT INTO public.standard (name, reference, area_of_concern_id, assessment_tool_id, self_id) SELECT std.name, std.reference, at.id, aoc.id, std.id from mp.standard std, public.assessment_tool at, mp.assessment_tool mpat, public.area_of_concern aoc WHERE std.assessment_tool_id = mpat.id AND mpat.name = at.name AND aoc.self_id = std.area_of_concern_id;

ALTER TABLE public.measurable_element ADD COLUMN self_id INT DEFAULT 0;
INSERT INTO public.measurable_element (name, reference, standard_id, assessment_tool_id, self_id) SELECT me.name, me.reference, std.id, at.id, me.id from mp.measurable_element me, public.assessment_tool at, mp.assessment_tool mpat, public.standard std WHERE std.assessment_tool_id = mpat.id AND mpat.name = at.name AND std.self_id = me.standard_id;

ALTER TABLE public.checkpoint ADD COLUMN self_id INT DEFAULT 0;
INSERT INTO public.checkpoint (name, means_of_verification, is_default, am_observation, am_staff_interview, am_patient_interview, am_record_review, sort_order, score_levels, is_optional, measurable_element_id, checklist_id, self_id) SELECT cp.name, cp.means_of_verification, cp.is_default, cp.am_observation, cp.am_staff_interview, cp.am_patient_interview, cp.am_record_review, cp.sort_order, cp.score_levels, cp.is_optional, me.id, cl.id, cp.id from mp.checkpoint cp, public.checklist cl, public.measurable_element me WHERE cl.self_id = cp.checklist_id AND me.self_id = cp.measurable_element_id;

ALTER TABLE public.facility_assessment ADD COLUMN self_id INT DEFAULT 0;
INSERT INTO public.facility_assessment (facility_id, assessment_tool_id, end_date, series_name) SELECT me.name, me.reference, std.id, at.id, me.id from mp.measurable_element me, public.assessment_tool at, mp.assessment_tool mpat, public.standard std WHERE std.assessment_tool_id = mpat.id AND mpat.name = at.name AND std.self_id = me.standard_id;


-- DROP SELF_ID columns