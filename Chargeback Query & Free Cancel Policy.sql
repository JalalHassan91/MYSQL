SELECT 

CR.rental_id AS 'Rental ID',
AC.name AS 'Account Name',
IFNULL(CCM.free_cancel_package, '') AS 'Free Cancel Policy',
(SELECT 
		IFNULL(SUM(substring_index(substring_index(t3.invoice_line_items,',',6),':',-1)),0)FROM     backofficedb.transactions t3
       where CR.rental_id=t3.core_rental_id
  AND t3.transaction_type='ra_commission') AS 'Chargeback',
IFNULL((SELECT
		((v1.label))FROM
	backofficedb.vocabularies v1 where CR.integration_name_vid=v1.id),"") AS 'Integration Name',
CR.campaign_source AS 'Campaign Name',
date(CR.book_date) AS 'Book Date'


		FROM 
	  backofficedb.core_rentals CR
		LEFT JOIN
	  backofficedb.properties PR ON CR.nid=PR.nid
		LEFT JOIN
	backofficedb.accounts AC ON PR.account_id=AC.id
		LEFT JOIN
	backofficedb.channel_cancellation_mapping CCM ON CR.cancellation_policy_id=CCM.rental_policy_id
    
    
    GROUP BY CR.rental_id