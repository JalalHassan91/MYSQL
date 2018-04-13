SELECT 

PV.value AS 'Account Name',
OPT.uid AS 'Account ID',
CASE WHEN (OPT.use_realemail)=1 THEN "Real Email"
WHEN (OPT.use_realemail)!=1 THEN "Anonymous Email" END  AS 'Email Policy' 

FROM 

radb.manager_opt_master OPT
LEFT JOIN
radb.profile_value PV ON OPT.uid=PV.uid

Where

PV.fid=21
AND PV.value!=""