UPDATE facility SET district_id = (SELECT id from district where name = 'Bilaspur') WHERE district_id = (SELECT id from district where name = 'Kota');
DELETE FROM district WHERE name = 'Kota';