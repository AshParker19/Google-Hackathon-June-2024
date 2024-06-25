#!/bin/bash

# check if gcloud is installed and available in the PATH
# if ! command -v gcloud &> /dev/null
# then
#     echo "Error: gcloud command not found. Please install Google Cloud SDK and add it to your PATH."
#     exit 1
# fi

# get env variables
if [ -f .env ]; then
  export $(grep -v '^#' .env | grep -v '^GOOGLE_PRIVATE_KEY=' | xargs)
  GOOGLE_PRIVATE_KEY=$(grep '^GOOGLE_PRIVATE_KEY=' .env | cut -d '=' -f2-)
else
  echo "Error: .env file not found. Please create a .env file with the required environment variables."
  exit 1
fi

# variables
SERVICE_NAME="sublime-lyceum-426907-r9"
REGION="europe-west1"
ENV_VARS=$(grep -v '^#' .env | grep -v '^GOOGLE_PRIVATE_KEY=' | xargs | sed 's/ /,/g')

# update requirements
pip install -r requirements.txt > /dev/null 2>&1

# deploy command
gcloud run deploy $SERVICE_NAME                             \
    --source .                                              \
    --region $REGION                                        \
    --set-env-vars $ENV_VARS                                \
    --set-env-vars GOOGLE_PRIVATE_KEY="$GOOGLE_PRIVATE_KEY" \
    --allow-unauthenticated
