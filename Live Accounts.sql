SELECT mail AS 'Email',
CASE WHEN status=1 THEN "LIVE"
WHEN status=0 THEN "Deactivated"
END AS 'Account Status'

 FROM radb.users;