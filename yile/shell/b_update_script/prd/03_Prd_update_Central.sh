#!/bin/sh
now="$(date +'%Y%m%d')"
file1=/tmp/YGCentral
[ ! -f $file1 ] && { echo "$file1 not exit";exit; }
cp YGCentral/release/YGCentral YGCentral/backup/YGCentral_$now
cp $file1 YGCentral/release/YGCentral

echo "YGCenter updated"

