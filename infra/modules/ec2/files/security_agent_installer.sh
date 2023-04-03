#!/bin/bash 
# This script installs a security agent with a given configuration file and token 
set -e 
while [[ $# -gt 0 ]]; do 
 key="$1" 
 case $key in 
 --config) 
 CONFIG_FILE="$2" 
 if [ -z "$CONFIG_FILE" ]; then 
 echo "Configuration file not provided properly" 
 exit 1 
 fi 
 shift 
 shift 
 ;; 
 --token) 
 TOKEN="$2" 
 if [ -z "$TOKEN" ]; then 
 echo "Token not provided properly" 
 exit 1 
 fi 
 shift 
 shift 
 ;; 
 *) 
 echo "Invalid argument: $1" 
 exit 1 
 ;; 
 esac 
done 
if [ -z "$TOKEN" ]; then 
 echo "Token not provided properly" 
 exit 1 
fi 
if [ $? -eq 0 ]; then 
 echo "Agent Installation Succeeded" >> test.txt
else 
 echo "Agent Installation Failed" 
 exit 1 
fi