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


echo "Press Control + C to exit the script."


while true
    do
        STATS=$(ps -p $PROCESS_ID -o pid,%cpu,%mem,command| tail +2)
        DATE=$(date +%s)

        if [ ! -z "$STATS" ]; then
            STATS="$DATE $STATS $LOG_FILE"
            echo $STATS
            echo "$STATS" >> "$LOG_FILE"
        fi

        sleep $REFRESH_IN_SEC
    done