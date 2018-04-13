SELECT 
CSTM.commission_rate_c AS 'Commission Rate',
AC.name AS 'Account Name',
AC.billing_address_city AS 'Billing City',
CSTM.backoffice_account_id_c AS 'BO ID',
CSTM.manager_tier_c AS 'Tier',
CSTM.commission_model_c AS 'Commission Model'

FROM sugarcrm.accounts_cstm CSTM
LEFT JOIN
sugarcrm.accounts AC ON CSTM.id_c=AC.id

where AC.account_type='PropertyManager' 
AND
billing_address_city='Orlando' OR billing_address_city='Kissimme' OR billing_address_city='Clermont' OR billing_address_city='Winter Garden'
