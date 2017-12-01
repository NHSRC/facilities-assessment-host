INSERT INTO state (name, uuid) values ('A & N Islands', '74579ea2-d9bb-427f-bfaf-b0872afbb886'::UUID) ON CONFLICT (name) DO NOTHING;
INSERT INTO district (name, uuid, state_id) values ('North and Middle Andaman', '0b6a5784-56e8-45eb-8310-0d087c80f294'::UUID, (SELECT id FROM state WHERE name='A & N Islands')) ON CONFLICT (state_id, name) DO NOTHING;
INSERT INTO facility_type (name) values('Community Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('CHC Rangat', '2f941941-725e-426b-af5a-ff91f88d3d11'::UUID, (SELECT district.id FROM district, state WHERE district.name='North and Middle Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Community Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('District Hospital') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('Dr. R.P.Hospital', 'ff077aca-3bcd-4d1a-b0d2-571ee0d33268'::UUID, (SELECT district.id FROM district, state WHERE district.name='North and Middle Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='District Hospital')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('PHC Billiground', '238f53a4-2af0-4a0d-9083-f97c4caa4966'::UUID, (SELECT district.id FROM district, state WHERE district.name='North and Middle Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('PHC Baratang', '450c4297-3666-4f2c-9253-468b13e6a74c'::UUID, (SELECT district.id FROM district, state WHERE district.name='North and Middle Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('PHC Radha Nagar', '818e8348-8775-4f24-b7f7-c9ac9e88346a'::UUID, (SELECT district.id FROM district, state WHERE district.name='North and Middle Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('PHC Kalighat', 'f6fc6cfa-063b-4a13-b4bf-f2fee4c39026'::UUID, (SELECT district.id FROM district, state WHERE district.name='North and Middle Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Community Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('CHC Diglipur', '208af4fb-8bb7-443c-95bb-2876883720f4'::UUID, (SELECT district.id FROM district, state WHERE district.name='North and Middle Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Community Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('PHC Kadamtala', '0be76b45-ef27-4bea-a78c-6346d03a870f'::UUID, (SELECT district.id FROM district, state WHERE district.name='North and Middle Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('PHC Kishori Nagar', '697ee8cf-07d7-4555-8c06-0fab9f2cd1d8'::UUID, (SELECT district.id FROM district, state WHERE district.name='North and Middle Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('PHC Tugapur', '99c704d8-1425-4f2b-a15f-fad00141819e'::UUID, (SELECT district.id FROM district, state WHERE district.name='North and Middle Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('PHC Long Island', '54df3320-07ed-4c4d-a0cb-ab46dbbef26e'::UUID, (SELECT district.id FROM district, state WHERE district.name='North and Middle Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO district (name, uuid, state_id) values ('Nicobar', '784dd318-a80a-4f73-a66c-a84375ab84c7'::UUID, (SELECT id FROM state WHERE name='A & N Islands')) ON CONFLICT (state_id, name) DO NOTHING;
INSERT INTO facility_type (name) values('Community Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('CHC Nancowry', 'e3a4a845-c119-4c1e-8560-0e0658f2cbeb'::UUID, (SELECT district.id FROM district, state WHERE district.name='Nicobar' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Community Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('PHC Katchal', '61f77679-4ab1-405f-87b0-eb4224c16260'::UUID, (SELECT district.id FROM district, state WHERE district.name='Nicobar' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('PHC Gandhinagar', 'e91e3f50-3a15-4898-93c7-af12864a44c4'::UUID, (SELECT district.id FROM district, state WHERE district.name='Nicobar' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('PHC Campbell Bay', '59459e2c-1eb9-4123-9add-584fe138c5ea'::UUID, (SELECT district.id FROM district, state WHERE district.name='Nicobar' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('PHC Teressa', '994842ca-7c7c-4129-94dd-03596725a5a7'::UUID, (SELECT district.id FROM district, state WHERE district.name='Nicobar' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('District Hospital') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('BJR Hospital', '5809e314-98f5-4d0f-80cb-9d2714003394'::UUID, (SELECT district.id FROM district, state WHERE district.name='Nicobar' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='District Hospital')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO district (name, uuid, state_id) values ('South Andaman', 'ec0d283f-d401-4533-aae4-12c06ce1767d'::UUID, (SELECT id FROM state WHERE name='A & N Islands')) ON CONFLICT (state_id, name) DO NOTHING;
INSERT INTO facility_type (name) values('Urban Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('UHC Shadipur', 'e37d2c14-d926-4386-8cd4-47b14a77eca9'::UUID, (SELECT district.id FROM district, state WHERE district.name='South Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Urban Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('PHC Chouldari', 'd898a36e-3fd3-427d-b2fe-182221b96bd7'::UUID, (SELECT district.id FROM district, state WHERE district.name='South Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('PHC Hut Bay', '47ba9153-a4ce-41a6-a3d4-ec8b52a9fc20'::UUID, (SELECT district.id FROM district, state WHERE district.name='South Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('PHC Wimberlygunj', 'd5830d59-4941-463e-828c-83c89766d6d2'::UUID, (SELECT district.id FROM district, state WHERE district.name='South Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('PHC R K Pur', '538aed2d-f370-45a7-9628-c2ed94b73166'::UUID, (SELECT district.id FROM district, state WHERE district.name='South Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Urban Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('UHC Junglighat', 'ea3caacb-95cc-4730-a6c5-85c3a77c2b1b'::UUID, (SELECT district.id FROM district, state WHERE district.name='South Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Urban Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Urban Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('UHC Dairy Farm', 'e7cfdb78-a5aa-4a62-b738-6f4e91c4009a'::UUID, (SELECT district.id FROM district, state WHERE district.name='South Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Urban Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('PHC Havelock', '9dce182e-f1c3-43ae-8b1f-7bb4318f4c35'::UUID, (SELECT district.id FROM district, state WHERE district.name='South Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('PHC Tushnabad', '04ab48f7-35a7-4bcb-8649-4ee2b39435b6'::UUID, (SELECT district.id FROM district, state WHERE district.name='South Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('PHC Neil Island', '243d4334-9a7a-4ed5-a1fb-d14b863427b2'::UUID, (SELECT district.id FROM district, state WHERE district.name='South Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('PHC Garacharma', 'ad417732-33f2-4d86-aaa8-8b40e5da20c7'::UUID, (SELECT district.id FROM district, state WHERE district.name='South Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('PHC Manglutan', '4176c323-7c9c-473d-b0f2-b3097b223a32'::UUID, (SELECT district.id FROM district, state WHERE district.name='South Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('District Hospital') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('G.B.Pant Hospital', 'bf04ac8a-b8bb-4e62-b88a-3903816e2f81'::UUID, (SELECT district.id FROM district, state WHERE district.name='South Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='District Hospital')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Urban Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('UHC Delanipur', '96bc4190-73d2-4e40-9c20-e8d14305e890'::UUID, (SELECT district.id FROM district, state WHERE district.name='South Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Urban Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Urban Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('UHC Haddo', '043a6180-301c-4f1b-a4a1-f288da428821'::UUID, (SELECT district.id FROM district, state WHERE district.name='South Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Urban Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Community Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('CHC Bambooflat', '22dfa1ab-f08e-4f42-8ccc-8b7598e59f4c'::UUID, (SELECT district.id FROM district, state WHERE district.name='South Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Community Health Center')) on conflict (district_id, facility_type_id, name) do nothing;

INSERT INTO facility_type (name) values('Primary Health Center') on conflict (name) DO NOTHING;
INSERT INTO facility (name, uuid, district_id, facility_type_id) values ('PHC Ferrargunj', 'b23af35a-7c40-469e-a2c9-0ef9520d2a4c'::UUID, (SELECT district.id FROM district, state WHERE district.name='South Andaman' and state.name='A & N Islands' and district.state_id = state.id), (SELECT id from facility_type where name='Primary Health Center')) on conflict (district_id, facility_type_id, name) do nothing;
