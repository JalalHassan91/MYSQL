SELECT
CR.rental_id AS 'Rental ID',
 DATE(CR.arrival_date) AS 'Checkin',
 DATE(T0.paid_date) AS 'Date Paid',
 T0.payment_status AS 'Payment Status',
 (SELECT	
		ac1.name FROM backofficedb.accounts ac1 LEFT JOIN backofficedb.properties pr1 ON pr1.account_id=ac1.id
        where CR.nid=pr1.nid) AS 'Account Name',
(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled' AND payment_status='paid') AS 'Rental Fee Paid to Manager',
  (SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled' AND payment_status='paid') AS 'Cleaning Fee Paid to Manager',
  (SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',3),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled' AND payment_status='paid')AS 'Taxes Paid to Manager',
  (SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',4),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled' AND payment_status='paid')AS 'Other Fees Paid to Manager',
  (SELECT 
		IFNULL(ROUND(SUM(substring_index(substring_index(t1.invoice_line_items,',',5),':', -1)),2),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled' AND payment_status='paid') AS 'Credit to Manager',
  (SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',6),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled' AND payment_status='paid') AS 'RA Commission Charged to Manager',
  (SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,'}',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled' AND payment_status='paid') AS 'CC Processing Charged to Manager',
  ROUND(((SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',2),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled' AND payment_status='paid')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',3),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled' AND payment_status='paid')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',4),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled' AND payment_status='paid')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled' AND payment_status='paid')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',6),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled' AND payment_status='paid')+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,'}',1),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled' AND payment_status='paid'))+(SELECT 
		IFNULL(SUM(substring_index(substring_index(t1.invoice_line_items,',',5),':', -1)),0)FROM     backofficedb.transactions t1
       where CR.rental_id=t1.core_rental_id
  AND t1.transaction_type='payment' AND payment_status!='Cancelled' AND payment_status='paid'),2) AS 'Total Payments to Manager'
  
  FROM	
	backofficedb.core_rentals CR 
		LEFT JOIN
	backofficedb.transactions T0 ON CR.rental_id=T0.core_rental_id
    
WHERE
(SELECT	
		ac1.name FROM backofficedb.accounts ac1 LEFT JOIN backofficedb.properties pr1 ON pr1.account_id=ac1.id
        where CR.nid=pr1.nid)='Best Beach Getaways' # This filter is for the account Name, only change the portion in green
AND(T0.paid_date BETWEEN "2018-01-01" AND "2018-03-14") 
#AND CR.rid=87654
AND T0.transaction_type='payment'
AND T0.payment_status='paid'
AND T0.payment_status!='cancelled'

