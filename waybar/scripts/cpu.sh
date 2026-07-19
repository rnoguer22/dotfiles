#!/bin/bash

# --- CPU usage (%) ---
read -r _ user1 nice1 system1 idle1 iowait1 irq1 softirq1 steal1 _ </proc/stat
sleep 0.4
read -r _ user2 nice2 system2 idle2 iowait2 irq2 softirq2 steal2 _ </proc/stat

idle_prev=$((idle1 + iowait1))
idle_now=$((idle2 + iowait2))
total_prev=$((user1 + nice1 + system1 + idle1 + iowait1 + irq1 + softirq1 + steal1))
total_now=$((user2 + nice2 + system2 + idle2 + iowait2 + irq2 + softirq2 + steal2))

diff_total=$((total_now - total_prev))
diff_idle=$((idle_now - idle_prev))

if [[ "$diff_total" -gt 0 ]]; then
  usage=$(((100 * (diff_total - diff_idle)) / diff_total))
else
  usage=0
fi

# --- CPU temperature (k10temp, found dynamically to survive hwmon renumbering) ---
temp=""
for hwmon in /sys/class/hwmon/hwmon*; do
  if [[ "$(cat "$hwmon/name" 2>/dev/null)" == "k10temp" ]]; then
    temp_raw=$(cat "$hwmon/temp1_input" 2>/dev/null)
    temp=$(awk "BEGIN { printf \"%.0f\", $temp_raw/1000 }")
    break
  fi
done
temp="${temp:-N/A}"

echo "${usage}% ${temp}°C"
