#!/bin/bash

LOG_DIR="/Users/nnaminkoussekennethjames/Desktop/logs"
APP_LOG="application.log"
SYS_LOG="system.log"

# this is an array.
ERROR_PATTERNS=("ERROR" "kernel")
REPORT_FILE="$LOG_DIR/log_analysis_report.txt"
echo "====================================" > "$REPORT_FILE"
echo "=======analysing log file===========" >> "$REPORT_FILE"
echo "====================================" >> "$REPORT_FILE"


echo -e "\n====================================" >> "$REPORT_FILE"
echo "List of log files  modified in 24hr" >> "$REPORT_FILE"
echo  "====================================" >> "$REPORT_FILE"


# a away of puting the output of a command in a variable.
LOG_FILES=$(find $LOG_DIR -name "*.log" -mtime -1)
echo "$LOG_FILES" >> "$REPORT_FILE"

for LOG_FILE in $LOG_FILES; do 

    echo -e "\n" >> "$REPORT_FILE"
    echo "====================================" >> "$REPORT_FILE"
    echo "===========$LOG_FILE================" >> "$REPORT_FILE"
    echo "====================================" >> "$REPORT_FILE"

    for PATTERN in ${ERROR_PATTERNS[@]}; do
        echo -e "\n $PATTERN in  $LOG_FILE file" >> "$REPORT_FILE"
        grep "$PATTERN" $LOG_FILE >> "$REPORT_FILE"

        echo -e "\n number of $PATTERN in $LOG_FILE file" >> "$REPORT_FILE"

        ERROR_COUNT=$(grep -c "$PATTERN" $LOG_FILE )
        echo $ERROR_COUNT >> "$REPORT_FILE"

        if [ "$ERROR_COUNT" -gt 1 ]; then
            echo -e "\n ⚠️ Action Required : to many $PATTERN in our log file"
        fi
    done
done
echo -e "\n Log analysis completed and info save in $REPORT_FILE "
