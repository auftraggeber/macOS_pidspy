#!/bin/bash

echo "----------[Retrieve Process IDs]----------" &&
./macos_getpid.sh &&
echo "------------[Monitor Process]-------------" &&
./macos_pidspy.sh