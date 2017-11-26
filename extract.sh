#!/bin/bash
START="$1"
END="$2"
cat > config.yml << EOF
in:
 type: mongodb
 uri: mongodb://localhost:27017/tweet
 collection: sample
 query: '{"_timestamp": { \$gte: "${START}", \$lt: "${END}" }}'
 projection: '{ "timestamp_ms": 1, "lang": 1, "text": 1 }'
out:
 type: file
 path_prefix: /tmp/twitter_sample_${START}/
 file_ext: json.gz
 formatter:
   type: jsonl
 encoders:
 - type: gzip
EOF
#rm -rf /tmp/twitter_sample_${START}
#mkdir /tmp/twitter_sample_${START}
embulk run config.yml