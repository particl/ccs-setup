# WARNING!

* Change the MYSQL_ROOT_PASSWORD in `mysql.env`.
* Change the hostname & the version in ccs.nginx
* Change hostname & repo & auth tokens in ccs.env

# First time
* First run might fail due to MySQL not being initialized. Watch MySQL output and wait till the server is listening.
* The next run WILL fail due to the database not having migrated. I didn't force this as it may result in loss of data.
```
docker exec -it crowdfundingsystem_crowdfunding_1 /bin/bash
cd /var/www/html/ccs-back
php artisan migrate:fresh
```

Then select yes.
* The final run should succeed.