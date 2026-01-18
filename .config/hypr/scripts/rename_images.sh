#!/bin/bash

i=1
for file in *; do
  mv "$file" "$i.${file##*.}"
  ((i++))
done
