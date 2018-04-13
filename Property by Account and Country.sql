SELECT
  NP.uid AS 'Property Manager ID',
  pv.value AS 'Property Manager',
  COUNT(NP.nid) AS 'Count of Live Properties',
  PR.country AS 'Country',
  PR.province AS 'Province/State',
  TD.name AS 'Region'
 
FROM
  radb.node NP
      LEFT JOIN
  radb.profile_value pv ON NP.uid = pv.uid
		LEFT JOIN
radb.field_data_field_geolocation GEO ON NP.nid=GEO.entity_id
		LEFT JOIN
radb.location PR ON GEO.field_geolocation_lid=PR.lid
	LEFT JOIN
field_data_taxonomy_vocabulary_1 V1 ON NP.nid=V1.entity_id
	LEFT JOIN
taxonomy_term_data TD ON V1.taxonomy_vocabulary_1_tid=TD.tid

WHERE
  NP.status = 1
      AND NP.type = 'rental_property'
      AND pv.fid = 21
      AND TD.vid=1
     
     GROUP BY pv.value, PR.country, PR.province, TD.name
     