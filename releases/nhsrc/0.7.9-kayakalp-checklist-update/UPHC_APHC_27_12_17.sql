insert into area_of_concern (uuid, name, reference, assessment_tool_id) select 'ee9ff470-7629-42f9-b85f-8683a899081b', 'Beyond Hospital Boundary', 'G', (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select area_of_concern.id from area_of_concern, assessment_tool where area_of_concern.reference = 'G' and area_of_concern.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC');
insert into standard (uuid, name, reference, area_of_concern_id, assessment_tool_id) select '96932ea3-badd-45d6-91c6-31286a9cb666', 'Maintenance of surrounding area and Waste Management', 'G4', (select area_of_concern.id from area_of_concern, assessment_tool where area_of_concern.reference = 'G' and area_of_concern.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select standard.id from assessment_tool, standard where standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC' and standard.reference = 'G4');
insert into measurable_element (uuid, name, reference, standard_id, assessment_tool_id) select 'de366b37-7da4-42a7-9771-3d3354ea4488', 'Regular repairs and maintained of roads, footpaths and pavements', 'G4.5', (select standard.id from standard, assessment_tool where standard.reference = 'G4' and standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select measurable_element.id from assessment_tool, measurable_element where assessment_tool.name = 'UPHC and APHC' and measurable_element.reference = 'G4.5' and measurable_element.assessment_tool_id = assessment_tool.id);
insert into checkpoint (uuid, name, means_of_verification, measurable_element_id, checklist_id, is_default, am_observation, am_staff_interview, am_patient_interview, am_record_review, sort_order, is_optional, score_levels) values ('8ae28c26-789d-4b4e-afac-ec7dbd14554c', 'Regular repairs and maintained of roads, footpaths and pavements', '1.0', (select measurable_element.id from measurable_element, assessment_tool where measurable_element.reference = 'G4.5' and measurable_element.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from checklist where name = 'Kayakalp' and assessment_tool_id = (select id from assessment_tool where name = 'UPHC and APHC')), true, false, false, false, true, 0, false, 3);
insert into measurable_element (uuid, name, reference, standard_id, assessment_tool_id) select '397267d4-8423-494e-a521-95d018d93c5e', 'Availability of garbage storage area', 'G4.2', (select standard.id from standard, assessment_tool where standard.reference = 'G4' and standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select measurable_element.id from assessment_tool, measurable_element where assessment_tool.name = 'UPHC and APHC' and measurable_element.reference = 'G4.2' and measurable_element.assessment_tool_id = assessment_tool.id);
insert into checkpoint (uuid, name, means_of_verification, measurable_element_id, checklist_id, is_default, am_observation, am_staff_interview, am_patient_interview, am_record_review, sort_order, is_optional, score_levels) values ('0c7d86d0-6bb8-44e5-92bd-581170d293b8', 'Availability of garbage storage area', '1.0', (select measurable_element.id from measurable_element, assessment_tool where measurable_element.reference = 'G4.2' and measurable_element.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from checklist where name = 'Kayakalp' and assessment_tool_id = (select id from assessment_tool where name = 'UPHC and APHC')), true, false, true, false, false, 0, false, 3);
insert into measurable_element (uuid, name, reference, standard_id, assessment_tool_id) select 'b8b8da78-7074-494a-89ab-771a64d0eb2e', 'Innovations in managing waste', 'G4.3', (select standard.id from standard, assessment_tool where standard.reference = 'G4' and standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select measurable_element.id from assessment_tool, measurable_element where assessment_tool.name = 'UPHC and APHC' and measurable_element.reference = 'G4.3' and measurable_element.assessment_tool_id = assessment_tool.id);
insert into checkpoint (uuid, name, means_of_verification, measurable_element_id, checklist_id, is_default, am_observation, am_staff_interview, am_patient_interview, am_record_review, sort_order, is_optional, score_levels) values ('25db0a94-3bfe-421e-b973-cc1527fca2a0', 'Innovations in managing waste', '1.0', (select measurable_element.id from measurable_element, assessment_tool where measurable_element.reference = 'G4.3' and measurable_element.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from checklist where name = 'Kayakalp' and assessment_tool_id = (select id from assessment_tool where name = 'UPHC and APHC')), true, false, false, false, false, 0, false, 3);
insert into measurable_element (uuid, name, reference, standard_id, assessment_tool_id) select 'fcf9c2c8-256d-43ea-9b5e-ddbb4fc9a55a', 'Availability of bins for General recyclable and biodegradable wastes', 'G4.1', (select standard.id from standard, assessment_tool where standard.reference = 'G4' and standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select measurable_element.id from assessment_tool, measurable_element where assessment_tool.name = 'UPHC and APHC' and measurable_element.reference = 'G4.1' and measurable_element.assessment_tool_id = assessment_tool.id);
insert into checkpoint (uuid, name, means_of_verification, measurable_element_id, checklist_id, is_default, am_observation, am_staff_interview, am_patient_interview, am_record_review, sort_order, is_optional, score_levels) values ('06331e9e-f491-40c4-ad25-953bd4f62bbe', 'Availability of bins for General recyclable and biodegradable wastes', '1.0', (select measurable_element.id from measurable_element, assessment_tool where measurable_element.reference = 'G4.1' and measurable_element.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from checklist where name = 'Kayakalp' and assessment_tool_id = (select id from assessment_tool where name = 'UPHC and APHC')), true, false, false, false, false, 0, false, 3);
insert into measurable_element (uuid, name, reference, standard_id, assessment_tool_id) select 'c79ad765-6bf8-4d19-b781-9b0b80ba62f3', 'Surrounding areas are well maintained', 'G4.4', (select standard.id from standard, assessment_tool where standard.reference = 'G4' and standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select measurable_element.id from assessment_tool, measurable_element where assessment_tool.name = 'UPHC and APHC' and measurable_element.reference = 'G4.4' and measurable_element.assessment_tool_id = assessment_tool.id);
insert into checkpoint (uuid, name, means_of_verification, measurable_element_id, checklist_id, is_default, am_observation, am_staff_interview, am_patient_interview, am_record_review, sort_order, is_optional, score_levels) values ('df6abeb1-61d0-4d7b-bb4e-e5c1e6679551', 'Surrounding areas are well maintained', '1.0', (select measurable_element.id from measurable_element, assessment_tool where measurable_element.reference = 'G4.4' and measurable_element.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from checklist where name = 'Kayakalp' and assessment_tool_id = (select id from assessment_tool where name = 'UPHC and APHC')), true, false, false, false, true, 0, false, 3);
insert into standard (uuid, name, reference, area_of_concern_id, assessment_tool_id) select '199eb127-127a-4d15-a3b9-ea4f51ebd6b0', 'Aesthetics and amenities of Surrounding area', 'G3', (select area_of_concern.id from area_of_concern, assessment_tool where area_of_concern.reference = 'G' and area_of_concern.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select standard.id from assessment_tool, standard where standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC' and standard.reference = 'G3');
insert into measurable_element (uuid, name, reference, standard_id, assessment_tool_id) select 'def89431-f102-4a9f-9651-4a9ef2a538e2', 'No loose hanging wires in and around the bill boards, electrical poles, etc.', 'G3.3', (select standard.id from standard, assessment_tool where standard.reference = 'G3' and standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select measurable_element.id from assessment_tool, measurable_element where assessment_tool.name = 'UPHC and APHC' and measurable_element.reference = 'G3.3' and measurable_element.assessment_tool_id = assessment_tool.id);
insert into checkpoint (uuid, name, means_of_verification, measurable_element_id, checklist_id, is_default, am_observation, am_staff_interview, am_patient_interview, am_record_review, sort_order, is_optional, score_levels) values ('9f3eb3f7-54ac-45e9-a76f-db18e07e604a', 'No loose hanging wires in and around the bill boards, electrical poles, etc.', '1.0', (select measurable_element.id from measurable_element, assessment_tool where measurable_element.reference = 'G3.3' and measurable_element.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from checklist where name = 'Kayakalp' and assessment_tool_id = (select id from assessment_tool where name = 'UPHC and APHC')), true, false, false, false, false, 0, false, 3);
insert into measurable_element (uuid, name, reference, standard_id, assessment_tool_id) select '639c2b52-468b-4fab-ab95-686374815270', 'Parks and green areas of surrounding area are well maintained', 'G3.1', (select standard.id from standard, assessment_tool where standard.reference = 'G3' and standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select measurable_element.id from assessment_tool, measurable_element where assessment_tool.name = 'UPHC and APHC' and measurable_element.reference = 'G3.1' and measurable_element.assessment_tool_id = assessment_tool.id);
insert into checkpoint (uuid, name, means_of_verification, measurable_element_id, checklist_id, is_default, am_observation, am_staff_interview, am_patient_interview, am_record_review, sort_order, is_optional, score_levels) values ('2632ad86-8216-4b11-baa0-f5b432eb4e19', 'Parks and green areas of surrounding area are well maintained', '1.0', (select measurable_element.id from measurable_element, assessment_tool where measurable_element.reference = 'G3.1' and measurable_element.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from checklist where name = 'Kayakalp' and assessment_tool_id = (select id from assessment_tool where name = 'UPHC and APHC')), true, false, false, false, true, 0, false, 3);
insert into measurable_element (uuid, name, reference, standard_id, assessment_tool_id) select '721b5fd3-dde3-4a6f-bcfa-0f72d0456dce', 'Availability of public toilets in surrounding area', 'G3.4', (select standard.id from standard, assessment_tool where standard.reference = 'G3' and standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select measurable_element.id from assessment_tool, measurable_element where assessment_tool.name = 'UPHC and APHC' and measurable_element.reference = 'G3.4' and measurable_element.assessment_tool_id = assessment_tool.id);
insert into checkpoint (uuid, name, means_of_verification, measurable_element_id, checklist_id, is_default, am_observation, am_staff_interview, am_patient_interview, am_record_review, sort_order, is_optional, score_levels) values ('6f2861dd-c0ed-4580-8795-e2ecec4fb363', 'Availability of public toilets in surrounding area', '1.0', (select measurable_element.id from measurable_element, assessment_tool where measurable_element.reference = 'G3.4' and measurable_element.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from checklist where name = 'Kayakalp' and assessment_tool_id = (select id from assessment_tool where name = 'UPHC and APHC')), true, false, false, false, false, 0, false, 3);
insert into measurable_element (uuid, name, reference, standard_id, assessment_tool_id) select 'da82cb58-7be5-4f57-b38e-1029b19d9881', 'Availability of adequate parking stand in surrounding area', 'G3.5', (select standard.id from standard, assessment_tool where standard.reference = 'G3' and standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select measurable_element.id from assessment_tool, measurable_element where assessment_tool.name = 'UPHC and APHC' and measurable_element.reference = 'G3.5' and measurable_element.assessment_tool_id = assessment_tool.id);
insert into checkpoint (uuid, name, means_of_verification, measurable_element_id, checklist_id, is_default, am_observation, am_staff_interview, am_patient_interview, am_record_review, sort_order, is_optional, score_levels) values ('f04495fe-f78d-4819-97ea-ccad407ba550', 'Availability of adequate parking stand in surrounding area', '1.0', (select measurable_element.id from measurable_element, assessment_tool where measurable_element.reference = 'G3.5' and measurable_element.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from checklist where name = 'Kayakalp' and assessment_tool_id = (select id from assessment_tool where name = 'UPHC and APHC')), true, false, false, false, false, 0, false, 3);
insert into measurable_element (uuid, name, reference, standard_id, assessment_tool_id) select 'b4bf132b-4560-4f57-8446-b5c9edf20325', 'No unwanted/broken/ torn / loose hanging posters/ billboards.', 'G3.2', (select standard.id from standard, assessment_tool where standard.reference = 'G3' and standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select measurable_element.id from assessment_tool, measurable_element where assessment_tool.name = 'UPHC and APHC' and measurable_element.reference = 'G3.2' and measurable_element.assessment_tool_id = assessment_tool.id);
insert into checkpoint (uuid, name, means_of_verification, measurable_element_id, checklist_id, is_default, am_observation, am_staff_interview, am_patient_interview, am_record_review, sort_order, is_optional, score_levels) values ('9bcb290e-0510-436b-a525-b52e7b78cdbc', 'No unwanted/broken/ torn / loose hanging posters/ billboards.', '1.0', (select measurable_element.id from measurable_element, assessment_tool where measurable_element.reference = 'G3.2' and measurable_element.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from checklist where name = 'Kayakalp' and assessment_tool_id = (select id from assessment_tool where name = 'UPHC and APHC')), true, false, false, true, true, 0, false, 3);
insert into standard (uuid, name, reference, area_of_concern_id, assessment_tool_id) select 'c334f157-6861-44d2-a8b8-18ab92c6f933', 'Cleanliness of approach road and surrounding area', 'G2', (select area_of_concern.id from area_of_concern, assessment_tool where area_of_concern.reference = 'G' and area_of_concern.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select standard.id from assessment_tool, standard where standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC' and standard.reference = 'G2');
insert into measurable_element (uuid, name, reference, standard_id, assessment_tool_id) select 'ed779dbb-7299-4b56-b8b8-0a6aabf8cd09', 'Area around the facility is clean, neat & tidy', 'G2.1', (select standard.id from standard, assessment_tool where standard.reference = 'G2' and standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select measurable_element.id from assessment_tool, measurable_element where assessment_tool.name = 'UPHC and APHC' and measurable_element.reference = 'G2.1' and measurable_element.assessment_tool_id = assessment_tool.id);
insert into checkpoint (uuid, name, means_of_verification, measurable_element_id, checklist_id, is_default, am_observation, am_staff_interview, am_patient_interview, am_record_review, sort_order, is_optional, score_levels) values ('69a5216c-7f84-4cda-bb71-6ae7eade1aec', 'Area around the facility is clean, neat & tidy', '1.0', (select measurable_element.id from measurable_element, assessment_tool where measurable_element.reference = 'G2.1' and measurable_element.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from checklist where name = 'Kayakalp' and assessment_tool_id = (select id from assessment_tool where name = 'UPHC and APHC')), true, false, false, false, true, 0, false, 3);
insert into measurable_element (uuid, name, reference, standard_id, assessment_tool_id) select 'a61dc422-5e66-4d22-9a40-765b60de3719', 'All drain and sewer are covered.', 'G2.4', (select standard.id from standard, assessment_tool where standard.reference = 'G2' and standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select measurable_element.id from assessment_tool, measurable_element where assessment_tool.name = 'UPHC and APHC' and measurable_element.reference = 'G2.4' and measurable_element.assessment_tool_id = assessment_tool.id);
insert into checkpoint (uuid, name, means_of_verification, measurable_element_id, checklist_id, is_default, am_observation, am_staff_interview, am_patient_interview, am_record_review, sort_order, is_optional, score_levels) values ('7a66a7c5-f6d6-4bae-985a-7decca59bc71', 'All drain and sewer are covered.', '1.0', (select measurable_element.id from measurable_element, assessment_tool where measurable_element.reference = 'G2.4' and measurable_element.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from checklist where name = 'Kayakalp' and assessment_tool_id = (select id from assessment_tool where name = 'UPHC and APHC')), true, false, false, false, false, 0, false, 3);
insert into measurable_element (uuid, name, reference, standard_id, assessment_tool_id) select 'f79709ba-628c-4e8d-9cad-c1391d9d1cf7', 'On the way signages are available', 'G2.2', (select standard.id from standard, assessment_tool where standard.reference = 'G2' and standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select measurable_element.id from assessment_tool, measurable_element where assessment_tool.name = 'UPHC and APHC' and measurable_element.reference = 'G2.2' and measurable_element.assessment_tool_id = assessment_tool.id);
insert into checkpoint (uuid, name, means_of_verification, measurable_element_id, checklist_id, is_default, am_observation, am_staff_interview, am_patient_interview, am_record_review, sort_order, is_optional, score_levels) values ('069c9d5c-b9b1-4555-be55-f99af7af10d6', 'On the way signages are available', '1.0', (select measurable_element.id from measurable_element, assessment_tool where measurable_element.reference = 'G2.2' and measurable_element.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from checklist where name = 'Kayakalp' and assessment_tool_id = (select id from assessment_tool where name = 'UPHC and APHC')), true, false, true, false, false, 0, false, 3);
insert into measurable_element (uuid, name, reference, standard_id, assessment_tool_id) select 'cfc3e591-30e3-4098-a929-7c9ec61eb401', 'Approach road is even and free from pot-holes', 'G2.3', (select standard.id from standard, assessment_tool where standard.reference = 'G2' and standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select measurable_element.id from assessment_tool, measurable_element where assessment_tool.name = 'UPHC and APHC' and measurable_element.reference = 'G2.3' and measurable_element.assessment_tool_id = assessment_tool.id);
insert into checkpoint (uuid, name, means_of_verification, measurable_element_id, checklist_id, is_default, am_observation, am_staff_interview, am_patient_interview, am_record_review, sort_order, is_optional, score_levels) values ('f7be8873-b074-4bf9-b116-4f2bc261d44f', 'Approach road is even and free from pot-holes', '1.0', (select measurable_element.id from measurable_element, assessment_tool where measurable_element.reference = 'G2.3' and measurable_element.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from checklist where name = 'Kayakalp' and assessment_tool_id = (select id from assessment_tool where name = 'UPHC and APHC')), true, false, false, false, false, 0, false, 3);
insert into measurable_element (uuid, name, reference, standard_id, assessment_tool_id) select '97e51280-3c13-4ebc-a53c-45cb66dd7f92', 'Functional street lights are available along the approach road', 'G2.5', (select standard.id from standard, assessment_tool where standard.reference = 'G2' and standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select measurable_element.id from assessment_tool, measurable_element where assessment_tool.name = 'UPHC and APHC' and measurable_element.reference = 'G2.5' and measurable_element.assessment_tool_id = assessment_tool.id);
insert into checkpoint (uuid, name, means_of_verification, measurable_element_id, checklist_id, is_default, am_observation, am_staff_interview, am_patient_interview, am_record_review, sort_order, is_optional, score_levels) values ('f10f3c4d-ab88-4a3e-9556-724cf86ea834', 'Functional street lights are available along the approach road', '1.0', (select measurable_element.id from measurable_element, assessment_tool where measurable_element.reference = 'G2.5' and measurable_element.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from checklist where name = 'Kayakalp' and assessment_tool_id = (select id from assessment_tool where name = 'UPHC and APHC')), true, false, false, false, false, 0, false, 3);
insert into standard (uuid, name, reference, area_of_concern_id, assessment_tool_id) select '886b8d5b-60fc-458d-b932-c73469690112', 'Promotion of Swachhata & Coordination with Local bodies', 'G1', (select area_of_concern.id from area_of_concern, assessment_tool where area_of_concern.reference = 'G' and area_of_concern.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select standard.id from assessment_tool, standard where standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC' and standard.reference = 'G1');
insert into measurable_element (uuid, name, reference, standard_id, assessment_tool_id) select 'e0882eaa-ee32-4a5d-aa2e-9ba4397ce7fb', 'Local community actively participates during Swachhata Pakhwara (Fortnight)', 'G1.1', (select standard.id from standard, assessment_tool where standard.reference = 'G1' and standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select measurable_element.id from assessment_tool, measurable_element where assessment_tool.name = 'UPHC and APHC' and measurable_element.reference = 'G1.1' and measurable_element.assessment_tool_id = assessment_tool.id);
insert into checkpoint (uuid, name, means_of_verification, measurable_element_id, checklist_id, is_default, am_observation, am_staff_interview, am_patient_interview, am_record_review, sort_order, is_optional, score_levels) values ('3f9ac218-b303-421e-b2c1-8a86c4c3c3c2', 'Local community actively participates during Swachhata Pakhwara (Fortnight)', '1.0', (select measurable_element.id from measurable_element, assessment_tool where measurable_element.reference = 'G1.1' and measurable_element.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from checklist where name = 'Kayakalp' and assessment_tool_id = (select id from assessment_tool where name = 'UPHC and APHC')), true, false, false, false, false, 0, false, 3);
insert into measurable_element (uuid, name, reference, standard_id, assessment_tool_id) select '841d1c70-30d4-4235-bfe3-956e02df0be7', 'Implementation of IEC activities related to '' Swachh Bharat Abhiyan''', 'G1.2', (select standard.id from standard, assessment_tool where standard.reference = 'G1' and standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select measurable_element.id from assessment_tool, measurable_element where assessment_tool.name = 'UPHC and APHC' and measurable_element.reference = 'G1.2' and measurable_element.assessment_tool_id = assessment_tool.id);
insert into checkpoint (uuid, name, means_of_verification, measurable_element_id, checklist_id, is_default, am_observation, am_staff_interview, am_patient_interview, am_record_review, sort_order, is_optional, score_levels) values ('a4c6bf27-3f43-4449-9eba-49360978b1df', 'Implementation of IEC activities related to '' Swachh Bharat Abhiyan''', '1.0', (select measurable_element.id from measurable_element, assessment_tool where measurable_element.reference = 'G1.2' and measurable_element.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from checklist where name = 'Kayakalp' and assessment_tool_id = (select id from assessment_tool where name = 'UPHC and APHC')), true, false, false, false, false, 0, false, 3);
insert into measurable_element (uuid, name, reference, standard_id, assessment_tool_id) select '2a0b02a2-3f0d-4f6d-b16f-8ff6860b7e0c', 'Community awareness by organising cultural programme and competitions', 'G1.3', (select standard.id from standard, assessment_tool where standard.reference = 'G1' and standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select measurable_element.id from assessment_tool, measurable_element where assessment_tool.name = 'UPHC and APHC' and measurable_element.reference = 'G1.3' and measurable_element.assessment_tool_id = assessment_tool.id);
insert into checkpoint (uuid, name, means_of_verification, measurable_element_id, checklist_id, is_default, am_observation, am_staff_interview, am_patient_interview, am_record_review, sort_order, is_optional, score_levels) values ('2f1b9199-e9cf-404c-9c03-e51f06d63364', 'Community awareness by organising cultural programme and competitions', '1.0', (select measurable_element.id from measurable_element, assessment_tool where measurable_element.reference = 'G1.3' and measurable_element.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from checklist where name = 'Kayakalp' and assessment_tool_id = (select id from assessment_tool where name = 'UPHC and APHC')), true, false, false, false, false, 0, false, 3);
insert into measurable_element (uuid, name, reference, standard_id, assessment_tool_id) select '010a02d2-2fcd-4eb9-ad2f-54ab155dd4cd', 'The Facility coordinates with other departments for improving Swachhata', 'G1.5', (select standard.id from standard, assessment_tool where standard.reference = 'G1' and standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select measurable_element.id from assessment_tool, measurable_element where assessment_tool.name = 'UPHC and APHC' and measurable_element.reference = 'G1.5' and measurable_element.assessment_tool_id = assessment_tool.id);
insert into checkpoint (uuid, name, means_of_verification, measurable_element_id, checklist_id, is_default, am_observation, am_staff_interview, am_patient_interview, am_record_review, sort_order, is_optional, score_levels) values ('ed5a53ec-f182-4c2d-b8b1-a744fa675a64', 'The Facility coordinates with other departments for improving Swachhata', '1.0', (select measurable_element.id from measurable_element, assessment_tool where measurable_element.reference = 'G1.5' and measurable_element.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from checklist where name = 'Kayakalp' and assessment_tool_id = (select id from assessment_tool where name = 'UPHC and APHC')), true, false, false, false, false, 0, false, 3);
insert into measurable_element (uuid, name, reference, standard_id, assessment_tool_id) select 'd01f6eca-7847-4c76-a66d-3a8ea413ff43', 'The Facility coordinates with local Gram Panchayat/ Urban local bodies and NGOs for improving the sanitation and hygiene', 'G1.4', (select standard.id from standard, assessment_tool where standard.reference = 'G1' and standard.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from assessment_tool where name = 'UPHC and APHC') where not exists (select measurable_element.id from assessment_tool, measurable_element where assessment_tool.name = 'UPHC and APHC' and measurable_element.reference = 'G1.4' and measurable_element.assessment_tool_id = assessment_tool.id);
insert into checkpoint (uuid, name, means_of_verification, measurable_element_id, checklist_id, is_default, am_observation, am_staff_interview, am_patient_interview, am_record_review, sort_order, is_optional, score_levels) values ('9f9f5141-1361-44d2-9834-2dd115cf4e74', 'The Facility coordinates with local Gram Panchayat/ Urban local bodies and NGOs for improving the sanitation and hygiene', '1.0', (select measurable_element.id from measurable_element, assessment_tool where measurable_element.reference = 'G1.4' and measurable_element.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from checklist where name = 'Kayakalp' and assessment_tool_id = (select id from assessment_tool where name = 'UPHC and APHC')), true, false, true, false, true, 0, false, 3);
insert into checklist_area_of_concern (area_of_concern_id, checklist_id) values ((select area_of_concern.id from area_of_concern, assessment_tool where area_of_concern.reference = 'G' and area_of_concern.assessment_tool_id = assessment_tool.id and assessment_tool.name = 'UPHC and APHC'), (select id from checklist where name = 'Kayakalp' and assessment_tool_id = (select id from assessment_tool where name = 'UPHC and APHC')));