curl -XPUT https://192.168.33.30:9200/_ingest/pipeline/techlog -v -u admin:admin --insecure -H 'Content-Type: application/json' -d @techlog-pipeline.json
