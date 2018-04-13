SELECT
  NP.uid AS 'Property Manager ID',
  pv.value AS 'Property Manager',
  CP.channel AS 'Channel',
  NP.nid AS 'NID',
  CASE WHEN CP.status='1' THEN "LIVE" END AS 'Channel Status',
  PR.country AS 'Country',
  TD.name AS 'Region',
  PR.city AS 'City'
  
 
FROM
radb.node NP
      INNER JOIN
radb.channel_properties CP ON NP.nid=CP.nid
	LEFT JOIN
radb.profile_value pv ON NP.uid = pv.uid
		LEFT JOIN
radb.field_data_field_geolocation GEO ON NP.nid=GEO.entity_id
		LEFT JOIN
radb.location PR ON GEO.field_geolocation_lid=PR.lid
	LEFT JOIN
radb.taxonomy_index DX ON NP.nid=DX.nid
	LEFT JOIN
radb.taxonomy_term_data TD ON DX.tid=TD.tid

WHERE
   CP.status=1
      AND NP.type = 'rental_property'
      AND pv.fid = 21
      AND TD.vid=1