#!/bin/sh
now="$(date +'%Y%m%d')"
file1=/tmp/YGAPI
file2=/tmp/YGAPI_for_develop
file3=/tmp/YGAPI_H5_Log
file4=/tmp/YGAPI_Alert

if [ -f $file1 ]; then
cp YGAPI/release/YGAPI YGAPI/backup/YGAPI_$now
cp $file1 YGAPI/release/YGAPI

echo "YGAPI updated"

else

echo "$file1 not exist"

fi

if [ -f $file2 ]; then
cp YGAPI_for_develop/release/YGAPI_for_develop YGAPI_for_develop/backup/YGAPI_for_develop_$now
cp $file2 YGAPI_for_develop/release/YGAPI_for_develop

echo "YGAPI_for_develop updated"

else

echo "$file2 not exist"

fi


if [ -f $file3 ]; then

cp YGAPI_H5_Log/release/YGAPI_H5_Log YGAPI_H5_Log/backup/YGAPI_H5_Log_$now
cp $file3 YGAPI_H5_Log/release/YGAPI_H5_Log

echo "YGAPI_H5_Log updated"

else

echo "$file3 not exist"

fi

if [ -f $file4 ]; then

cp YGAPI_Alert/release/YGAPI_Alert YGAPI_Alert/backup/YGAPI_Alert_$now
cp $file4 YGAPI_Alert/release/YGAPI_Alert

echo "YGAPI_Alert updated"

else

echo "$file4 not exist"

fi
