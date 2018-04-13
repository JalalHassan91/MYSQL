SELECT RP.cid as 'RID', 
RP.token_amount AS 'Initial Charge',
CASE WHEN (RP.token_amount)<=250 THEN "<250"
WHEN (RP.token_amount)<=500 THEN "250-500"		
WHEN (RP.token_amount)<=750 THEN "500-750"       
WHEN (RP.token_amount)<=1000 THEN "750-1000"
WHEN (RP.token_amount)<=1500 THEN "1000-1500"
WHEN (RP.token_amount)<=2000 THEN "1500-2000"
WHEN (RP.token_amount)<=2500 THEN "2000-2500"
WHEN (RP.token_amount)>2500 THEN  "2500+" END AS 'Price Range'

FROM radb.report RP