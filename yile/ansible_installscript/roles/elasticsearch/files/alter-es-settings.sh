#!/bin/sh
curl -XPUT "http://127.0.0.1:9200/_settings" -u elastic:Log@n0vu3 -H 'Content-Type: application/json' -d '{
    "index" : {
        "highlight.max_analyzed_offset" : 100000000
    }
}'

curl -XPUT "http://127.0.0.1:9200/_settings" -u elastic:Log@n0vu3 -H 'Content-Type: application/json' -d '
#{
  "number_of_replicas" : 0
}'