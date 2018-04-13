SELECT 
PV.value AS 'Account Name',
US.name AS 'Account Email',
US.uid AS 'Manager ID',
CM.channel AS 'Channel',
CM.percent_markup AS 'Channel Markup %' 



 FROM 
 radb.manager_channel_markup CM
 LEFT JOIN
 radb.users US ON US.uid=CM.mid
 LEFT JOIN
 radb.profile_value PV ON US.uid=PV.uid
 LEFT JOIN
 radb.users_roles UR ON US.uid=UR.uid
 
 Where PV.fid=21 AND UR.rid=8 AND PV.value='Padre Island Rentals'