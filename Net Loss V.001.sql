SELECT
 
 ac1.name AS 'Account Name',
 US.email AS 'Account Email',
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
 WHEN CR.channel_name_vid=114 THEN "Choice Hotels"
 WHEN CR.channel_name_vid=115 THEN "Glamping Hub"
 WHEN CR.campaign_source='RedAwning' THEN "RedAwning"
 WHEN CR.channel_name_vid=32 THEN "Holiday_Lettings"
 WHEN CR.channel_name_vid=30 THEN "Flipkey"
 WHEN CR.channel_name_vid=52 THEN "Test" 
 WHEN CR.channel_name_vid=35 THEN "Kigo"
 WHEN CR.channel_name_vid=34 THEN "Tripping" END AS 'Markup % Channel',
	CR.status AS 'Status',
CR.rental_id AS 'Rental ID',
ac1.id AS 'Account ID',
DATE(CR.book_date) AS 'Book Date',
    IFNULL((SELECT
		((v1.label))FROM
	backofficedb.vocabularies v1 where CR.integration_name_vid=v1.id),"") AS 'Integration',
    pr1.nid AS 'NID',
     (SELECT  
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded') AS 'Total Rental Charge',
  (SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded') AS 'Total Cleaning Fee',
  (SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',4),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded') AS 'Damage Waiver',
  (SELECT 
		IFNULL(ROUND(SUM(substring_index(substring_index(t2.invoice_line_items,',',3),':', -1)),2),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded') AS 'Total Tax',
  (SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,'}',1),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded') AS 'Other Fees Collected',
      (SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled') AS 'Rental Fee Paid to Manager',
  (SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled') AS 'Cleaning Fee Paid to Manager',
  (SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',3),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')AS 'Taxes Paid to Manager',
  (SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',4),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')AS 'Other Fees Paid to Manager',
  (SELECT 
		IFNULL(ROUND(SUM(substring_index(substring_index(t1.invoice_line_items,',',5),':', -1)),2),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled') AS 'Credit to Manager',
  (SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',6),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled') AS 'RA Commission Charged to Manager',
  (SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,'}',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled') AS 'CC Processing Charged to Manager',
  ROUND(((SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',3),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',4),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',6),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,'}',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled'))+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',5),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled'),2) AS 'Total Payments to Manager',
  ROUND((SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',3),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',4),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,'}',1),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded'),2) AS 'Total Collections',
    
  (SELECT 
		IFNULL(SUM(substring_index(substring_index(t3.invoice_line_items,',',4),':', -1)),0)FROM     backofficedb.transactions t3
       where CR.rental_id=t3.core_rental_id
  AND t3.transaction_type='ra_commission') AS 'Markup',
  (SELECT
		IFNULL((ROUND(SUM(t4.amount),2)),"")FROM backofficedb.transactions t4
			where CR.rental_id=t4.core_rental_id AND t4.transaction_type='Channel_Price_Discrepancy') AS 'Channel Price Discrepancy',
 ROUND(((((SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',3),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',4),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,'}',1),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined'AND payment_status!='refunded')-((SELECT
		IFNULL(SUM(t8.amount),0) FROM backofficedb.transactions t8
	  where CR.rental_id=t8.core_rental_id AND t8.transaction_type='refund' AND t8.payment_status!='cancelled'))+(SELECT
		IFNULL(SUM(t9.amount),0) FROM backofficedb.transactions t9
	 where CR.rental_id=t9.core_rental_id AND t9.transaction_type='collection' AND t9.payment_status='refunded'))
     -((SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',3),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',4),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',6),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,'}',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled'))-(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',5),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')))+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t3.invoice_line_items,',',5),':', -1)),0)-((SELECT
		IFNULL(SUM(t5.amount),0)FROM backofficedb.transactions t5
			where CR.rental_id=t5.core_rental_id AND t5.transaction_type='channel_commission' AND t5.payment_status!='Cancelled')+(SELECT
		IFNULL(SUM(t6.amount),0)FROM backofficedb.transactions t6
			where CR.rental_id=t6.core_rental_id AND t6.transaction_type='PMS_Commission' AND t6.payment_status!='Cancelled'))FROM     backofficedb.transactions t3
       where CR.rental_id=t3.core_rental_id
  AND t3.transaction_type='ra_commission' AND t3.payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t3.invoice_line_items,',',6),':',-1)),0)FROM     backofficedb.transactions t3
       where CR.rental_id=t3.core_rental_id
  AND t3.transaction_type='ra_commission'),2) AS 'Net Earnings',
  CASE 
  WHEN	
  (SELECT 
		IFNULL(ROUND(SUM(substring_index(substring_index(t2.invoice_line_items,',',3),':', -1)),2),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded' AND CR.campaign_source!='AirBnB')<(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',3),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled' AND CR.campaign_source!='AirBnB') AND (SELECT  
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded' AND CR.campaign_source!='AirBnB')<(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled' AND CR.campaign_source!='AirBnB') AND (SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded' AND CR.campaign_source!='AirBnB')<(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled' AND CR.campaign_source!='AirBnB') THEN "Rent+CF+Tax Mismatch" 
  WHEN (SELECT 
		IFNULL(ROUND(SUM(substring_index(substring_index(t2.invoice_line_items,',',3),':', -1)),2),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded' AND CR.campaign_source!='AirBnB')<(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',3),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled' AND CR.campaign_source!='AirBnB') AND (SELECT  
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded' AND CR.campaign_source!='AirBnB')<(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled' AND CR.campaign_source!='AirBnB') THEN "Rent+Tax Mismatch"
  WHEN (SELECT 
		IFNULL(ROUND(SUM(substring_index(substring_index(t2.invoice_line_items,',',3),':', -1)),2),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded' AND CR.campaign_source!='AirBnB')<(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',3),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled' AND CR.campaign_source!='AirBnB') AND (SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded' AND CR.campaign_source!='AirBnB')<(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled' AND CR.campaign_source!='AirBnB') THEN "CF+Tax Mismatch"
  WHEN (SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')<(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled') AND (SELECT  
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')<(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled') THEN "Rent+CF Mismatch"
  
  WHEN (SELECT  
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')<(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled') THEN "Rent Mismatch"
  WHEN (SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')<(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled') THEN "CF Mismatch"
  WHEN (SELECT 
		IFNULL(ROUND(SUM(substring_index(substring_index(t2.invoice_line_items,',',3),':', -1)),2),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded' AND CR.campaign_source!='AirBnB')<(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',3),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled' AND CR.campaign_source!='AirBnB') THEN "Tax Mismatch"
  WHEN  ROUND(((((SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',3),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',4),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,'}',1),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined'AND payment_status!='refunded')-((SELECT
		IFNULL(SUM(t8.amount),0) FROM backofficedb.transactions t8
	  where CR.rental_id=t8.core_rental_id AND t8.transaction_type='refund' AND t8.payment_status!='cancelled'))+(SELECT
		IFNULL(SUM(t9.amount),0) FROM backofficedb.transactions t9
	 where CR.rental_id=t9.core_rental_id AND t9.transaction_type='collection' AND t9.payment_status='refunded'))
     -((SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',3),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',4),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',6),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,'}',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled'))-(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',5),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')))+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t3.invoice_line_items,',',5),':', -1)),0)-((SELECT
		IFNULL(SUM(t5.amount),0)FROM backofficedb.transactions t5
			where CR.rental_id=t5.core_rental_id AND t5.transaction_type='channel_commission' AND t5.payment_status!='Cancelled')+(SELECT
		IFNULL(SUM(t6.amount),0)FROM backofficedb.transactions t6
			where CR.rental_id=t6.core_rental_id AND t6.transaction_type='PMS_Commission' AND t6.payment_status!='Cancelled'))FROM     backofficedb.transactions t3
       where CR.rental_id=t3.core_rental_id
  AND t3.transaction_type='ra_commission' AND t3.payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t3.invoice_line_items,',',6),':',-1)),0)FROM     backofficedb.transactions t3
       where CR.rental_id=t3.core_rental_id
  AND t3.transaction_type='ra_commission'),2)=(SELECT 
		IFNULL(SUM(substring_index(substring_index(t3.invoice_line_items,',',5),':', -1)),0)FROM     backofficedb.transactions t3
       where CR.rental_id=t3.core_rental_id
  AND t3.transaction_type='ra_commission') THEN "CC Fee Loss"
  WHEN (SELECT 
		IFNULL(SUM(substring_index(substring_index(t3.invoice_line_items,',',6),':',-1)),0)FROM     backofficedb.transactions t3
       where CR.rental_id=t3.core_rental_id
  AND t3.transaction_type='ra_commission')<0 THEN "Chargeback"
  WHEN   ROUND(((((SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',3),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',4),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,'}',1),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')-((SELECT
		IFNULL(SUM(t8.amount),0) FROM backofficedb.transactions t8
	  where CR.rental_id=t8.core_rental_id AND t8.transaction_type='refund' AND t8.payment_status!='cancelled'))+(SELECT
		IFNULL(SUM(t9.amount),0) FROM backofficedb.transactions t9
	 where CR.rental_id=t9.core_rental_id AND t9.transaction_type='collection' AND t9.payment_status='refunded')))-(((SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',3),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',4),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',6),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,'}',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled'))+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',5),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')))-(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',4),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded'),2)<(SELECT
		IFNULL(ROUND(SUM(t5.amount),2),0)FROM backofficedb.transactions t5
			where CR.rental_id=t5.core_rental_id AND t5.transaction_type='channel_commission' AND t5.payment_status!='Cancelled') OR   ROUND(((((SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',3),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',4),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,'}',1),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined'AND payment_status!='refunded')-((SELECT
		IFNULL(SUM(t8.amount),0) FROM backofficedb.transactions t8
	  where CR.rental_id=t8.core_rental_id AND t8.transaction_type='refund' AND t8.payment_status!='cancelled'))+(SELECT
		IFNULL(SUM(t9.amount),0) FROM backofficedb.transactions t9
	 where CR.rental_id=t9.core_rental_id AND t9.transaction_type='collection' AND t9.payment_status='refunded'))
     -((SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',3),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',4),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',6),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,'}',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled'))-(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',5),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')))+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t3.invoice_line_items,',',5),':', -1)),0)-((SELECT
		IFNULL(SUM(t5.amount),0)FROM backofficedb.transactions t5
			where CR.rental_id=t5.core_rental_id AND t5.transaction_type='channel_commission' AND t5.payment_status!='Cancelled')+(SELECT
		IFNULL(SUM(t6.amount),0)FROM backofficedb.transactions t6
			where CR.rental_id=t6.core_rental_id AND t6.transaction_type='PMS_Commission' AND t6.payment_status!='Cancelled'))FROM     backofficedb.transactions t3
       where CR.rental_id=t3.core_rental_id
  AND t3.transaction_type='ra_commission' AND t3.payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t3.invoice_line_items,',',6),':',-1)),0)FROM     backofficedb.transactions t3
       where CR.rental_id=t3.core_rental_id
  AND t3.transaction_type='ra_commission'),2)<0 THEN "Margin Issue"
	ELSE "" END AS 'Automated Loss Cause',
   IFNULL((SELECT
	MIN((CRA.accounting_tag)) FROM backofficedb.core_rentals_additional CRA
	where CR.rental_id=CRA.core_rental_id),"") AS 'Net Loss Cause',

     ROUND(((SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,'}',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')*-1)/((SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')),2) AS 'CC Commission %',
    CASE WHEN MIN(vocabularies.label='Commission RF ') THEN ROUND(((SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',6),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')*-1)/(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled'),3)
		WHEN  MIN(vocabularies.label='Commission RF+CF') THEN ROUND(((SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',6),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')*-1)/((SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')),3)
       WHEN  MIN(vocabularies.label='Commission RF+CF+Tax') THEN ROUND(((SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',6),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')*-1)/((SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',3),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')),3) Else "0" END AS 'Commission %',
  CASE WHEN MIN(vocabularies.label='Commission RF ') THEN ROUND('.235'-((((SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',6),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')*-1)/(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled'))),3)
		WHEN  MIN(vocabularies.label='Commission RF+CF') THEN ROUND('.235'-((((SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',6),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')*-1)/((SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')))),3)
       WHEN  MIN(vocabularies.label='Commission RF+CF+Tax') THEN ROUND('.235'-((((SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',6),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')*-1)/((SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',3),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')))),3) Else (('.235')-ROUND(((SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,'}',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')*-1)/((SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')),2)) END AS 'Estimated Markup %',
  MIN(IFNULL((vocabularies.label), 'No Commission')) AS 'Commission Type'
  
        
  
  FROM
  
	backofficedb.core_rentals CR
    	LEFT JOIN 
	backofficedb.properties pr1 ON CR.nid=pr1.nid
		LEFT JOIN
	backofficedb.accounts ac1 ON pr1.account_id=ac1.id
		LEFT JOIN
	backofficedb.users US ON ac1.user_id=US.id
		INNER JOIN 
    backofficedb.accounts_rental_policies_relations ON ac1.id = accounts_rental_policies_relations.account_id
		INNER jOIN 
    backofficedb.rental_policies_relations ON accounts_rental_policies_relations.rental_policy_id = rental_policies_relations.rental_policy_id
		LEFT OUTER  JOIN
    backofficedb.rental_policies ON accounts_rental_policies_relations.rental_policy_id = rental_policies.id
		LEFT OUTER  JOIN
    backofficedb.policies ON rental_policies_relations.policy_id = policies.id
		LEFT OUTER JOIN
    backofficedb.vocabularies ON policies.fee_type_vid = vocabularies.id
      AND vocabularies.label LIKE '%Commission%'
    WHERE
    
    campaign_source!='TEST' AND ac1.name NOT LIKE '%TEST%' AND accounts_rental_policies_relations.channel_vid = '0' AND ac1.id=956
    
    GROUP BY CR.rental_id
    
   
   
    
    