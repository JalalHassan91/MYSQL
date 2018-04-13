SELECT
  NP.uid AS 'Property Manager ID',
  pv.value AS 'Property Manager',
  CP.channel AS 'Channel',
  CASE WHEN CP.status='1' THEN "Live" ELSE "Offline" END AS 'Property Status on Channel'
  
 
FROM
radb.node NP
	INNER JOIN
radb.channel_properties CP ON NP.nid=CP.nid
	INNER JOIN
radb.profile_value pv ON NP.uid = pv.uid
	INNER JOIN
radb.users US ON pv.uid=US.uid

WHERE
      NP.type = 'rental_property'
      AND pv.fid = 21
      AND US.status=1
      
       
      GROUP BY  CP.channel, pv.value
      ORDER BY pv.value
