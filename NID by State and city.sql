SELECT 
nid AS 'Node ID',
name AS 'Property Name',
state AS 'Property State',
city AS 'Property City'


FROM 
	backofficedb.properties PR

WHERE
	PR.city LIKE'%Stateline%' 
	OR PR.city LIKE'%South Lake Tahoe%'
    OR PR.city LIKE'%Tahoe%'
    OR PR.city LIKE '%Truckee%'
    OR PR.city LIKE'%Incline Village%'
    OR PR.city LIKE'%Zephyr Cove%'
    OR PR.city LIKE '%Mammoth%'
    OR PR.city LIKE'%Big Bear%'
    OR PR.state='Colorado'
    OR PR.state='CO'
    OR PR.state='UT'
    OR PR.state='Utah'
    OR PR.state='WY'
    OR PR.state='Wyoming'