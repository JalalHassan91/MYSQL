SELECT 

CR.rental_id AS 'Rental ID',
AC.name AS 'Account Name',
IFNULL(CCM.free_cancel_package, 'no free cancel') AS 'Free Cancel Policy',
CR.status AS'Status',
CASE WHEN CR.channel_name_vid=31 THEN "Homeaway"
 WHEN CR.channel_name_vid=83 THEN "Homeaway"
 WHEN CR.channel_name_vid=82 THEN "Homeaway"
 WHEN CR.channel_name_vid=66 THEN "Homeaway"
 WHEN CR.channel_name_vid=34 THEN "Expedia"
 WHEN CR.channel_name_vid=68 THEN "Expedia"
 WHEN CR.channel_name_vid=33 THEN "Bookingcom"
 WHEN CR.channel_name_vid=44 THEN "AirBnB"
 WHEN CR.channel_name_vid=0 THEN "RedAwning"
 WHEN CR.channel_name_vid=53 THEN "RedAwning"
 WHEN CR.channel_name_vid=52 THEN "RedAwning"
 WHEN CR.channel_name_vid=84 THEN "RedAwning"
 WHEN CR.campaign_source='RedAwning' THEN "RedAwning"
 WHEN CR.campaign_source='glampinghub' THEN "Glampinghub"
 WHEN CR.channel_name_vid=32 THEN "Holiday_Lettings"
 WHEN CR.channel_name_vid=30 THEN "Flipkey"
 WHEN CR.channel_name_vid=52 THEN "Test" 
 WHEN CR.channel_name_vid=35 THEN "Kigo"
 WHEN CR.channel_name_vid=34 THEN "Tripping" END AS 'Channel Name',
IFNULL((SELECT
		((v1.label))FROM
	backofficedb.vocabularies v1 where CR.integration_name_vid=v1.id),"") AS 'Integration Name',
CR.campaign_source AS 'Campaign Name',
date(CR.book_date) AS 'Book Date',
timestamp(CR.created_at) AS 'Book Time',
CR.cancellation_timestamp AS 'Cancellation Date',
timestampdiff(MINUTE, CR.created_at, CR.cancellation_timestamp)/60 AS 'Hours to Cancellation',
datediff(CR.arrival_date,CR.book_date) AS 'Days booked from arrival',
CASE WHEN datediff(CR.arrival_date,CR.book_date)<=7 THEN "Book7" 
WHEN datediff(CR.arrival_date,CR.book_date)<=14 THEN "Book14" 
WHEN datediff(CR.arrival_date,CR.book_date)<=30 THEN "Book30"
WHEN datediff(CR.arrival_date,CR.book_date)<=42 THEN "Book42"
WHEN datediff(CR.arrival_date,CR.book_date)<=60 THEN "Book60"
WHEN datediff(CR.arrival_date,CR.book_date)>60 THEN "Book60+" END AS 'Book Time Status',
CASE WHEN (timestampdiff(MINUTE, CR.created_at, CR.cancellation_timestamp)/60)<=24 THEN "Cancel24HRS"
WHEN (timestampdiff(MINUTE, CR.created_at, CR.cancellation_timestamp)/60)<=48 THEN "Cancel48HRS"		
WHEN (timestampdiff(MINUTE, CR.created_at, CR.cancellation_timestamp)/60)<=72 THEN "Cancel72HRS"       
WHEN (timestampdiff(MINUTE, CR.created_at, CR.cancellation_timestamp)/60)<=168 THEN "Cancel7DAYS"
WHEN (timestampdiff(MINUTE, CR.created_at, CR.cancellation_timestamp)/60)<=336 THEN "Cancel14DAYS"
WHEN (timestampdiff(MINUTE, CR.created_at, CR.cancellation_timestamp)/60)<=720 THEN "Cancel30DAYS"
WHEN (timestampdiff(MINUTE, CR.created_at, CR.cancellation_timestamp)/60)<=1440 THEN "Cancel60DAYS"
WHEN (timestampdiff(MINUTE, CR.created_at, CR.cancellation_timestamp)/60)>1440 THEN "Cancel60+DAYS" END AS 'Cancel Time Status'

        FROM 
	backofficedb.core_rentals CR
		LEFT JOIN
	backofficedb.properties PR ON CR.nid=PR.nid
		LEFT JOIN
	backofficedb.accounts AC ON PR.account_id=AC.id
		LEFT JOIN
	backofficedb.channel_cancellation_mapping CCM ON CR.cancellation_policy_id=CCM.rental_policy_id
	
    
 Group BY CR.rental_id