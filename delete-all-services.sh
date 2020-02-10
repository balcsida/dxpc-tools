#!/usr/bin/env bash

PROJECT_NAME=$1
ENVIRONMENT=$2

function check_command_exists() {
    command -v $1 >/dev/null 2>&1 || {
        echo >&2 "$1 is not available.  Aborting."
        exit 1
    }
}

# Check if required commands are available
check_command_exists lcp
check_command_exists jq

# Try to Login user
lcp login

# Check if LCP config file exists
LCP_CONFIG_FILE=$HOME/.lcp
if test -f "$LCP_CONFIG_FILE"; then
    echo "$LCP_CONFIG_FILE exists"
else
    echo "$LCP_CONFIG_FILE doesn't exist! Exciting..."
    exit 1;
fi

TOKEN=$(awk -F "=" '/token/ {print $2}' $LCP_CONFIG_FILE)

$SERVICES=$(curl -X GET https://api.liferay.cloud/projects/$PROJECT_NAME-$ENVIRONMENT/services -H 'dxpcloud-authorization: Bearer '$TOKEN | jq --compact-output '.[].serviceId')


for i in "${arrayName[@]}"
do
   : 
   # do whatever on $i
done