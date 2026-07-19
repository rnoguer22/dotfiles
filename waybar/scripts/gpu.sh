#!/bin/bash

# Output GPU usage %, VRAM used/total (GiB) and temperature

read -r util mem_used mem_total temp <<<"$(nvidia-smi \
  --query-gpu=utilization.gpu,memory.used,memory.total,temperature.gpu \
  --format=csv,noheader,nounits 2>/dev/null | tr -d ',')"

if [[ -z "$util" ]]; then
  echo "GPU N/A"
  exit 0
fi

mem_used_gb=$(awk "BEGIN { printf \"%.1f\", $mem_used/1024 }")
mem_total_gb=$(awk "BEGIN { printf \"%.1f\", $mem_total/1024 }")

echo "${util}% ${mem_used_gb}G/${mem_total_gb}G ${temp}°C 󰢮 "
