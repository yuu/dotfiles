#!/bin/bash

# input csv format
# filename, value
# ----
# a, https://google.com/a
input="url.csv"
output_dir=`mktemp -d`

mkdir -p "$output_dir"

tail -n +2 "$input" | while IFS=, read -r press_no url
do
  qrencode "$url" -o "$output_dir/${press_no}.png"
done

echo "generated to $output_dir"
