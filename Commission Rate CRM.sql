SELECT 
commission_rate_c AS 'Commission Rate',
AC.name AS 'Account Name',
CSTM.backoffice_account_id_c AS 'BO ID',
CSTM.manager_tier_c AS 'Tier'

FROM sugarcrm.accounts_cstm CSTM
LEFT JOIN
sugarcrm.accounts AC ON CSTM.id_c=AC.id

where 

AC.account_type='PropertyManager' 
