#!/bin/bash
filepath=$1
COUNTS=5


function ip_requests() {
    echo "Top $COUNTS IP addresses with the most requests:"
    awk '{print $1}' "$filepath" | sort | uniq -c | sort -nr | head -$COUNTS | awk '{print $2 " - " $1 " requests"}'
    echo ""
}
function path_requests() {
    echo "Top $COUNTS most requested paths:"
    awk '{print $7}' "$filepath" | sort | uniq -c | sort -nr | head -$COUNTS | awk '{print $2 " - " $1 " requests"}'
    echo ""
}
function status_codes() {
  echo "Top $COUNTS response status codes:"
  awk '{print $9}' "$filepath" | sort | uniq -c | sort -nr | head -$COUNTS | awk '{print $2 " - " $1 " requests"}'
  echo ""
}

if [ -z "$filepath" ]; then
  echo "Please give file's path!"
  exit 1
fi

if [ -f "$filepath" ]; then
  ip_requests
  path_requests
  status_codes
elif [ -d "$filepath" ]; then
  echo "This is directory not file"
else
  echo "This is not an existing file"
  exit 1
fi

