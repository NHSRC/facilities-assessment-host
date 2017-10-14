--- MOVE MP TABLE DATA TO SINGLE DATABASE
ALTER TABLE public.state ADD COLUMN self_id INT DEFAULT 0;
INSERT INTO public.state (name, self_id) SELECT name, id from mp.state ON CONFLICT DO NOTHING;
UPDATE public.state SET self_id = (SELECT mp.state.id from mp.state WHERE mp.state.name = 'Madhya Pradesh') WHERE public.state.name = 'Madhya Pradesh';

ALTER TABLE public.district ADD COLUMN self_id INT DEFAULT 0;
INSERT INTO public.district (name, state_id, self_id) SELECT d.name, s.id, d.id from mp.district d, public.state s WHERE d.state_id = s.self_id;

ALTER TABLE public.facility ADD COLUMN self_id INT DEFAULT 0;
INSERT INTO public.facility (name, district_id, facility_type_id, self_id) SELECT f.name, d.id, f.facility_type_id, f.id from mp.facility f, public.district d WHERE f.district_id = d.self_id;

ALTER TABLE public.department ADD COLUMN self_id INT DEFAULT 0;
INSERT INTO public.department (name, self_id, sort_order) SELECT d.name, d.id, d.sort_order from mp.department d;

ALTER TABLE public.checklist ADD COLUMN self_id INT DEFAULT 0;
INSERT INTO public.checklist (name, department_id, assessment_tool_id, self_id, state_id, created_date, last_modified_date) SELECT cl.name, d.id, at.id, cl.id, s.id, cl.created_date, cl.last_modified_date from mp.checklist cl, public.department d, public.assessment_tool at, mp.assessment_tool mpat, public.state s WHERE cl.assessment_tool_id = mpat.id AND mpat.name = at.name AND cl.department_id = d.self_id and cl.state_id = s.self_id;

ALTER TABLE public.area_of_concern ADD COLUMN self_id INT DEFAULT 0;
INSERT INTO public.area_of_concern (name, reference, assessment_tool_id, self_id, created_date, last_modified_date) SELECT aoc.name, aoc.reference, at.id, aoc.id, aoc.created_date, aoc.last_modified_date from mp.area_of_concern aoc, public.assessment_tool at, mp.assessment_tool mpat WHERE aoc.assessment_tool_id = mpat.id AND mpat.name = at.name;

INSERT INTO public.checklist_area_of_concern (area_of_concern_id, checklist_id) SELECT aoc.id, cl.id from mp.checklist_area_of_concern caoc, public.checklist cl, public.area_of_concern aoc WHERE caoc.checklist_id = cl.self_id AND caoc.area_of_concern_id = aoc.self_id;

ALTER TABLE public.standard ADD COLUMN self_id INT DEFAULT 0;
INSERT INTO public.standard (name, reference, area_of_concern_id, assessment_tool_id, self_id, created_date, last_modified_date) SELECT std.name, std.reference, aoc.id, at.id, std.id, std.created_date, std.last_modified_date from mp.standard std, public.assessment_tool at, mp.assessment_tool mpat, public.area_of_concern aoc WHERE std.assessment_tool_id = mpat.id AND mpat.name = at.name AND aoc.self_id = std.area_of_concern_id;

ALTER TABLE public.measurable_element ADD COLUMN self_id INT DEFAULT 0;
INSERT INTO public.measurable_element (name, reference, standard_id, assessment_tool_id, self_id, created_date, last_modified_date) SELECT me.name, me.reference, std.id, at.id, me.id, me.created_date, me.last_modified_date from mp.measurable_element me, public.assessment_tool at, mp.assessment_tool mpat, public.standard std WHERE std.assessment_tool_id = mpat.id AND mpat.name = at.name AND std.self_id = me.standard_id;

ALTER TABLE public.checkpoint ADD COLUMN self_id INT DEFAULT 0;
INSERT INTO public.checkpoint (name, means_of_verification, is_default, am_observation, am_staff_interview, am_patient_interview, am_record_review, sort_order, score_levels, is_optional, measurable_element_id, checklist_id, self_id, created_date, last_modified_date) SELECT cp.name, cp.means_of_verification, cp.is_default, cp.am_observation, cp.am_staff_interview, cp.am_patient_interview, cp.am_record_review, cp.sort_order, cp.score_levels, cp.is_optional, me.id, cl.id, cp.id, cp.created_date, cp.last_modified_date from mp.checkpoint cp, public.checklist cl, public.measurable_element me WHERE cl.self_id = cp.checklist_id AND me.self_id = cp.measurable_element_id;

ALTER TABLE public.facility_assessment ADD COLUMN self_id INT DEFAULT 0;
INSERT INTO public.facility_assessment (facility_id, assessment_tool_id, start_date, end_date, series_name, self_id, created_date, last_modified_date) SELECT f.id, at.id, fa.start_date, fa.end_date, fa.series_name, fa.id, fa.created_date, fa.last_modified_date from mp.facility_assessment fa, public.assessment_tool at, mp.assessment_tool mpat, public.facility f WHERE fa.assessment_tool_id = mpat.id AND mpat.name = at.name AND f.self_id = fa.facility_id;

INSERT INTO public.checkpoint_score (facility_assessment_id, checkpoint_id, checklist_id, score, remarks, created_date, last_modified_date) SELECT fa.id, cp.id, cl.id, cs.score, cs.remarks, cs.created_date, cs.last_modified_date from mp.checkpoint_score cs, public.checkpoint cp, public.checklist cl, public.facility_assessment fa WHERE cs.checklist_id = cl.self_id AND cs.checkpoint_id = cp.self_id and cs.facility_assessment_id = fa.self_id;

-- DROP SELF_ID columns
ALTER TABLE public.state DROP COLUMN self_id;
ALTER TABLE public.district DROP COLUMN self_id;
ALTER TABLE public.facility DROP COLUMN self_id;
ALTER TABLE public.department DROP COLUMN self_id;
ALTER TABLE public.checklist DROP COLUMN self_id;
ALTER TABLE public.area_of_concern DROP COLUMN self_id;
ALTER TABLE public.standard DROP COLUMN self_id;
ALTER TABLE public.measurable_element DROP COLUMN self_id;
ALTER TABLE public.checkpoint DROP COLUMN self_id;
ALTER TABLE public.facility_assessment DROP COLUMN self_id;