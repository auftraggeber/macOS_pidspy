#!/bin/bash

echo "Please enter the process name: "
read PROCESS_NAME

echo "Found pids: "
echo $(pgrep $PROCESS_NAME)