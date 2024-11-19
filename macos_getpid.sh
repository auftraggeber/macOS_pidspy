#!/bin/bash

echo "Please enter the process name: "
read PROCESS_NAME

echo "Found pids: $(pgrep $PROCESS_NAME)"