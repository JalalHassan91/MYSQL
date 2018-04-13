SELECT 

CR.rental_id AS 'Rental ID',
date(CR.book_date) AS 'Book Date',
date(CR.arrival_date) AS 'Arrival Date',
CR.first_name AS 'First Name',
CR.last_name AS 'Last Name',
CR.nid AS 'Node ID',
PR.name AS 'Property Name',
PR.city AS 'Property City',
PR.state AS 'Property State',
PR.zip AS 'Property ZIP',
CR.renter_email AS 'Renter Email',


ROUND(SUM((SELECT 
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
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined')),2) AS 'Total Collections',
  
  ROUND(SUM(((SELECT 
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
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined'))/CR.nights),2) AS 'Cost Per Night',
  
ROUND((SUM(((SELECT 
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
  AND t2.transaction_type='collection' AND payment_status!='Cancelled' AND payment_status!='declined'))/CR.nights)/CR.adult_guest),2)  AS 'Cost Per Person Per Night'
  
  

FROM 
	backofficedb.core_rentals CR
		LEFT JOIN 
	backofficedb.properties PR ON CR.nid=PR.nid
    
WHERE

	CR.status!='cancelled'


    
GROUP BY CR.rental_id
		
