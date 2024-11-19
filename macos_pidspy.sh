#!/bin/bash

echo "Please enter the process id you want to monitor: "
read PROCESS_ID

echo "Please enter the refresh rate in seconds: "
read REFRESH_IN_SEC

if [[ $REFRESH_IN_SEC -le 0 ]]; then
    echo "Please enter a valid time."
    exit;
fi

echo "Please enter the file to log to: "
read LOG_FILE

if [ -z "$LOG_FILE" ]; then
    echo "Please specify a valid file name".
    exit;
fi

if [ ! -f "$LOG_FILE" ]; then
    echo "TIME;PID;CPU%;MEMORY%;MEMORY;MEM_LIMIT;PAGE_FAULTS;STATE;LOG" >> "$LOG_FILE"
fi


echo "Press Control + C to exit the script."


while true
    do
        STATS=$(ps -p $PROCESS_ID -o pid,%cpu,%mem,rss,lim,pagein,state | tail +2)
        DATE=$(date +%s)

        if [ ! -z "$STATS" ]; then
            STATS="$DATE $STATS $LOG_FILE"
            ARRAY=($STATS)
            CSV_STATS=""

            for ELEMENT in "${ARRAY[@]}"
            do
                if [[ "$CSV_STATS" != "" ]]; then
                    CSV_STATS="$CSV_STATS;"
                fi
                CSV_STATS="$CSV_STATS$ELEMENT"
            done

            echo "$CSV_STATS"
            echo "$CSV_STATS" >> "$LOG_FILE"
        fi

        sleep $REFRESH_IN_SEC
    done