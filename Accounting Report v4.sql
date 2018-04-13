SELECT
	CR.rental_id AS 'Rental ID',
  	ac1.name  AS 'Account Name',
  IFNULL((v1.label),"") AS 'Integration Name',
    CR.status AS 'Status',
    DATE(CR.book_date) AS 'Book Date',
    DATE(CR.arrival_date) AS 'Checkin',
    DATE(CR.departure_date) AS 'Checkout',
     IFNULL((SELECT 
		(MIN(DATE(t10.due_date))) FROM backofficedb.transactions t10
        where CR.rental_id=t10.core_rental_id
	AND t10.transaction_type='payment' AND t10.payment_status='not paid'),"") AS 'Next Payment Due',
    IFNULL((CR.campaign_source ),"") AS 'Campaign Source',
    IFNULL((CR.channel_reservation_id),"") AS 'Channel Reservation ID',
		pr1.nid AS 'NID', 
		pr1.state AS 'Property State/Province',
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
  
  ROUND(((SELECT
		IFNULL(SUM(t8.amount),0)*-1 FROM backofficedb.transactions t8
	  where CR.rental_id=t8.core_rental_id AND t8.transaction_type='refund' AND t8.payment_status!='cancelled'))+(SELECT
		IFNULL(SUM(t9.amount),0) FROM backofficedb.transactions t9
	 where CR.rental_id=t9.core_rental_id AND t9.transaction_type='collection' AND t9.payment_status='refunded'),2) AS 'Refund',
	
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
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')-((SELECT
		IFNULL(SUM(t8.amount),0) FROM backofficedb.transactions t8
	  where CR.rental_id=t8.core_rental_id AND t8.transaction_type='refund' AND t8.payment_status!='cancelled'))+(SELECT
		IFNULL(SUM(t9.amount),0) FROM backofficedb.transactions t9
	 where CR.rental_id=t9.core_rental_id AND t9.transaction_type='collection' AND t9.payment_status='refunded'),2) AS 'Net Collections',
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
  ROUND((((SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined'  AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',3),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined'  AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',4),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined'  AND payment_status!='refunded')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,'}',1),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined'  AND payment_status!='refunded'))-((SELECT
		IFNULL(SUM(t8.amount),0) FROM backofficedb.transactions t8
	  where CR.rental_id=t8.core_rental_id AND t8.transaction_type='refund' AND t8.payment_status!='cancelled'))+(SELECT
		IFNULL(SUM(t9.amount),0) FROM backofficedb.transactions t9
	 where CR.rental_id=t9.core_rental_id AND t9.transaction_type='collection' AND t9.payment_status='refunded'))-(((SELECT 
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
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')))-(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',5),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled'),2) AS 'Gross Profit',
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
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded'),2) AS 'Net Profit',
  ROUND(((((SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',3),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',4),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,'}',1),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' ))-((SELECT 
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
  AND t1.transaction_type='payment' AND payment_status!='Cancelled')))-(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',4),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined'))/((SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',1),':', -1)),2)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled'))*100,2) AS 'Net Profit %',
  (SELECT 
		IFNULL(ROUND(SUM(substring_index(substring_index(t5.invoice_line_items,',',1),':', -1)),2),0)FROM     backofficedb.transactions t5
       where CR.rental_id=t5.core_rental_id
  AND t5.transaction_type='channel_commission' AND payment_status!='Cancelled') AS 'Commission Calculation Base',
  (SELECT 
		IFNULL(ROUND(SUM(substring_index(substring_index(t5.invoice_line_items,',',2),':', -1)),2),0)FROM     backofficedb.transactions t5
       where CR.rental_id=t5.core_rental_id
  AND t5.transaction_type='channel_commission' AND payment_status!='Cancelled') AS 'Channel Commission %',
  (SELECT
		IFNULL(ROUND(SUM(t5.amount),2),0)FROM backofficedb.transactions t5
			where CR.rental_id=t5.core_rental_id AND t5.transaction_type='channel_commission' AND t5.payment_status!='Cancelled') AS 'Channel Commission',
  (SELECT
		IFNULL(ROUND(SUM(t6.amount),2),0)FROM backofficedb.transactions t6
			where CR.rental_id=t6.core_rental_id AND t6.transaction_type='PMS_Commission' AND t6.payment_status!='Cancelled') AS 'PMS Commssion',
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
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded')-((SELECT
		IFNULL(SUM(t8.amount),0) FROM backofficedb.transactions t8
	  where CR.rental_id=t8.core_rental_id AND t8.transaction_type='refund' AND t8.payment_status!='cancelled'))+(SELECT
		IFNULL(SUM(t9.amount),0) FROM backofficedb.transactions t9
	 where CR.rental_id=t9.core_rental_id AND t9.transaction_type='collection' AND t9.payment_status='refunded'))-((SELECT 
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
  AND t1.transaction_type='payment' AND payment_status!='Cancelled'))-(SELECT 
		IFNULL(SUM(substring_index(substring_index(t2.invoice_line_items,',',4),':', -1)),0)FROM     backofficedb.transactions t2
       where CR.rental_id=t2.core_rental_id
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined' AND payment_status!='refunded'))-((SELECT
		IFNULL(SUM(t5.amount),0)FROM backofficedb.transactions t5
			where CR.rental_id=t5.core_rental_id AND t5.transaction_type='channel_commission' AND t5.payment_status!='Cancelled')+(SELECT
		IFNULL(SUM(t6.amount),0)FROM backofficedb.transactions t6
			where CR.rental_id=t6.core_rental_id AND t6.transaction_type='PMS_Commission' AND t6.payment_status!='Cancelled')),2) AS 'Profit After Channel and PMS Commission',
  (SELECT 
		IFNULL(SUM(substring_index(substring_index(t3.invoice_line_items,',',5),':', -1)),0)FROM     backofficedb.transactions t3
       where CR.rental_id=t3.core_rental_id
  AND t3.transaction_type='ra_commission') AS 'CC Cost Estimate',
  (SELECT 
		IFNULL(SUM(substring_index(substring_index(t3.invoice_line_items,',',6),':',-1)),0)FROM     backofficedb.transactions t3
       where CR.rental_id=t3.core_rental_id
  AND t3.transaction_type='ra_commission')  AS 'Chargeback',
  (SELECT 
		IFNULL(SUM(substring_index(substring_index(t3.invoice_line_items,'}',1),':',-1)),0)FROM     backofficedb.transactions t3
       where CR.rental_id=t3.core_rental_id
  AND t3.transaction_type='ra_commission')  AS 'Writedown/Writeoff',
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
  IFNULL((SELECT
	MIN((CRA.accounting_tag)) FROM backofficedb.core_rentals_additional CRA
	where CR.rental_id=CRA.core_rental_id),"") AS 'Net Loss Cause',
  IFNULL((SELECT
	MIN((CRA.accounting_notes)) FROM backofficedb.core_rentals_additional CRA
	where CR.rental_id=CRA.core_rental_id),"") AS 'Notes'
    
FROM	
	backofficedb.core_rentals CR 
		LEFT JOIN
	backofficedb.transactions T0 ON CR.rental_id=T0.core_rental_id
		LEFT JOIN 
	backofficedb.properties pr1 ON CR.nid=pr1.nid
		LEFT JOIN
	backofficedb.accounts ac1 ON pr1.account_id=ac1.id
		LEFT JOIN
	backofficedb.vocabularies v1 ON CR.integration_name_vid=v1.id
	
		
	
		
		

WHERE CR.campaign_source!='Test'
#AND (CR.book_date BETWEEN "2018-04-01" AND "2018-04-09") 
#AND (CR.arrival_date BETWEEN "2018-01-08" AND "2018-01-14") 
#AND (CR.departure_date BETWEEN "2018-03-01" AND "2018-03-14") 
#AND (T0.due_date BETWEEN "2018-03-08" AND "2018-03-14") 
#AND T0.transaction_type='payment'
#AND T0.payment_status='not paid'
#AND CR.rental_id=100701
#AND ac1.name='Best Beach Getaways'
#AND CR.campaign_source='Booking.com'
GROUP BY CR.rental_id

#Above are sample filters that can be used to pull the data, you can modify the filters to pull information for a specific accpunt, channel, reservation, 
#or range of dates; based on Book Date, Arrival Date, Departure Date or Payment Due Date.