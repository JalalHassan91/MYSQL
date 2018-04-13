SELECT 
NP.nid AS 'Node ID',
NP.title AS 'Property Name',
PR.province AS 'Property State',
PR.city AS 'Property City',
NP.status AS 'Status'


FROM 
	radb.node NP 
		LEFT JOIN
	radb.field_data_field_geolocation GEO ON NP.nid=GEO.entity_id
		LEFT JOIN
	radb.location PR ON GEO.field_geolocation_lid=PR.lid
    
WHERE
	NP.nid=45182