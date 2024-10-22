#!/bin/bash
# Automation script for uploading file to or emptying bucket. 
#
# Parameters
#   $1: Execution mode. Valid values: upload, empty.
#   $2: Project name - match to udagram-parameters.json file.
#   $3: Name of file to upload. E.g.: index.html

# Usage examples:
#   ./bucket.sh upload my-project-name my-file.html
#   ./bucket.sh empty my-project-name
#

# Validate parameters
if [[ $1 != "empty" && $1 != "upload" ]]; then
    echo "ERROR: Incorrect execution mode. Valid values: empty, upload." >&2
    exit 1
fi

# Save parameters as variables
EXECUTION_MODE=$1
PROJECT_NAME=$2
FILE_NAME=$3

# S3 API CLI commands
if [ $EXECUTION_MODE == "upload" ]
then
    aws s3api put-object \
        --bucket $PROJECT_NAME-udagram-4829 \
        --key $FILE_NAME \
        --body $FILE_NAME
fi

if [ $EXECUTION_MODE == "empty" ]
then
    aws s3 rm s3://$PROJECT_NAME-udagram-4829 \
        --recursive
fi