#!/bin/bash

# Check if gcloud is installed and available in the PATH
if ! command -v gcloud &> /dev/null
then
    echo "Error: gcloud command not found. Please install Google Cloud SDK and add it to your PATH."
    exit 1
fi

# Check if .env file exists
if [ ! -f .env ]; then
  echo "Error: .env file not found. Please create a .env file with the required environment variables."
  exit 1
fi

# Load environment variables, handling multiline variables separately
export $(grep -v '^#' .env | grep -v 'GOOGLE_PRIVATE_KEY' | xargs)
GOOGLE_PRIVATE_KEY=$(grep '^GOOGLE_PRIVATE_KEY' .env | cut -d '=' -f2-)

# Encode the GOOGLE_PRIVATE_KEY to make it compatible with the deployment
ENCODED_GOOGLE_PRIVATE_KEY=$(echo -e "$GOOGLE_PRIVATE_KEY" | base64 | tr -d '\n')

# Collect all other environment variables except GOOGLE_PRIVATE_KEY
OTHER_ENV_VARS=$(grep -v '^#' .env | grep -v 'GOOGLE_PRIVATE_KEY' | xargs | sed 's/ /,/g')

# Add the encoded GOOGLE_PRIVATE_KEY to the environment variables
ENV_VARS="$OTHER_ENV_VARS,GOOGLE_PRIVATE_KEY=$ENCODED_GOOGLE_PRIVATE_KEY"

# variables
SERVICE_NAME="sublime-lyceum-426907-r9"
REGION="europe-west1"

# update requirements
pip install -r requirements.txt > /dev/null 2>&1

# deploy command
gcloud run deploy $SERVICE_NAME \
    --source .                  \
    --region $REGION            \
    --set-env-vars $ENV_VARS    \
    --allow-unauthenticated
