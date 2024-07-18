#!/bin/bash

# Log file location in your home directory
LOG_FILE="/var/log/system_monitor.log"

# Function to get CPU usage
get_cpu_usage() {
    mpstat 1 1 | awk '/Average:/ { printf("%.2f%%\n", 100 - $12) }'
}

# Function to get RAM usage
get_ram_usage() {
    free -h | awk '/Mem:/ { printf("Used: %s, Total: %s, Free: %s\n", $3, $2, $4) }'
}

# Function to get storage usage
get_storage_usage() {
    df -h | awk '$NF=="/"{printf("Used: %s, Total: %s, Available: %s\n", $3, $2, $4)}'
}

# Function to log system usage
log_system_usage() {
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    CPU_USAGE=$(get_cpu_usage)
    RAM_USAGE=$(get_ram_usage)
    STORAGE_USAGE=$(get_storage_usage)

    echo "[$TIMESTAMP] CPU Usage: $CPU_USAGE" >> $LOG_FILE
    echo "[$TIMESTAMP] RAM Usage: $RAM_USAGE" >> $LOG_FILE
    echo "[$TIMESTAMP] Storage Usage: $STORAGE_USAGE" >> $LOG_FILE
    echo "------------------------------------" >> $LOG_FILE
}

# Display system usage
display_system_usage() {
    echo "CPU Usage: $(get_cpu_usage)"
    echo "RAM Usage: $(get_ram_usage)"
    echo "Storage Usage: $(get_storage_usage)"
}

# Ensure the log directory exists
mkdir -p $(dirname $LOG_FILE)

# Log and display system usage
log_system_usage
display_system_usage

