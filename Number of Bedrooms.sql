SELECT  

	 radb.field_data_field_bedrooms.field_bedrooms_value  AS 'Number of Bedrooms',
     node.nid AS 'NID'
     
FROM 
	radb.node  
		LEFT JOIN 
	radb.field_data_field_bedrooms  ON radb.node.nid=radb.field_data_field_bedrooms.entity_id
WHERE
	
 radb.node.type=radb.field_data_field_bedrooms.bundle 

