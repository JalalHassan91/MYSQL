SELECT 
AC.name AS 'Account Name',
US.email AS 'Account Email',
AC.phone_primary AS 'Account Phone',
AC.phone_mobile AS 'Account Mobile',
CASE WHEN CG.id>=0 THEN "Template Uploaded"
ELSE "Not Uploaded" END AS 'Uploaded',
CG.address AS 'CIA Address',
CG.phone1 AS 'CIA Phone 1',
CG.phone2 AS 'CIA Phone 2',
CG.email AS 'CIA Email'

FROM 
backofficedb.accounts AC
LEFT JOIN
backofficedb.cia_config CG ON AC.id=CG.account_id
LEFT JOIN 
backofficedb.users US ON AC.id=US.id
 