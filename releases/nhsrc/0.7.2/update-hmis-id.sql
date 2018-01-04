UPDATE facility SET hmis_code = other.hmis_id
FROM (SELECT facility.id facility_id, hmis_facility.FacilityId hmis_id from facility
  INNER JOIN district ON facility.district_id = district.id
  INNER JOIN state ON district.state_id = state.id
  INNER JOIN hmis_facility ON hmis_facility.FacilityName = facility.name AND hmis_facility.facilitytype not like 'Sub Centres%'
WHERE facility.district_id = district.id AND district.state_id = state.id AND state.name = 'Kerala') AS other
WHERE facility.id = facility_id;
