#!/bin/sh

date2=`date --date='0 days ago' "+%Y-%m-%d"`

mysql -h 10.0.2.5 -u root -p123456   << EOFMYSQL

use pd2new
SELECT IFNULL(SUM(ABS(gbu.winOrLoseCount)),0) AS water
FROM gl_betlogdetail_user gbu
WHERE gbu.openTime IS NOT NULL AND gbu.openTime LIKE "$date2 00:%";

 

SELECT SUM(totalDeposit) AS totalDeposit
FROM (
SELECT IFNULL(SUM(fo.totalvalue), 0) AS totalDeposit
FROM f_order fo
WHERE fo.orderStatus = 2 AND fo.lastUpdateTime LIKE '2020-08-14 00:%' UNION ALL
SELECT IFNULL(SUM(totalval), 0) AS totalDeposit
FROM f_order_fast fof
WHERE (fof.order_status=9 AND fof.financere_check_time IS NULL AND fof.finance_check_time LIKE '2020-08-14 00:%')) temp 

EOFMYSQL
