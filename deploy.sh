#!/bin/bash

# check if gcloud is installed and available in the PATH
if ! command -v gcloud &> /dev/null
then
    echo "Error: gcloud command not found. Please install Google Cloud SDK and add it to your PATH."
    exit 1
fi

# get env variables
if [ -f .env ]; then
  export $(grep -v '^#' .env | grep -v 'GOOGLE_PRIVATE_KEY' | xargs)
else
  echo "Error: .env file not found. Please create a .env file with the required environment variables."
  exit 1
fi

# variables
SERVICE_NAME="sublime-lyceum-426907-r9"
REGION="europe-west1"
GOOGLE_PRIVATE_KEY=GOOGLE_PRIVATE_KEY=-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC5pEdL7VyuMgZc\nfuzogEfL9P2IGXhepu7SckPsGDlAHsN6f6v9CEPDbXWh8ZRUj3rquNEvzht88vb4\nqyIh+38+UtgCZSCRDe5cbaNgTkXUpha+qrTJ3IUKOmxnZ1rCE5LRZpOtJiTvnB6k\nC77yXgvRQ8n7dvvzr5VbPIBLUUuWzb+OXhx9gJPtgWdTDLcrAm0et19aeZJRs4uV\nalHJs2bmvaDzOSm7s5vhMLZ9H6G6jdWhtfO+hgkasP5zgDEu5vwBm27AwESBlmU9\nC37ib/VjgwVRWeaGcKHdsYUd/2DgkyUxhvzllbQKrLjceTeeHSbB4PTbQ1Q7Q4jB\nBFzV64m3AgMBAAECggEAHlmjyF+Jj/cgwB2GKOrUEh2/F3Gmkr7y+5fvz9kT/w4o\ngk3+NdOUlI5ANZYz3HFKtLY7iPfG2bI1O2lrHqgp4OwVYarb3Kss5ZKNK9EQLJhs\nzoZFIV16qLXthChLF8Cwd6iwCxZZ4oyhG8vJz4EdqHxPONv2jBwQLIbjKK0lUQWR\npHGPWtB3vXIcSrF/BB1HWyQFQbACiN3WklstVHsn6ksbosYtbqHq6tcZ2x16b3bj\nbNB6RyStaNFTDDMtfnjWlxnetRb3X2MnBAPIixFWxgTadL5cq1fTxWjFLKadd/gk\nD9oRYI+6MLjErm0/Pw3lxTzqxY/5kjYpPaflPApv4QKBgQDwbugHXjRtnoslYjAC\nHvIwxGUTYt2LO1t0uv9aYbwz7+t85k308s3YRISAdQrJN53aGJr0GxZV8zeX2TqW\nbXBKZGz3+wKn3jI2wo3OVKCh/h9lEuJBJuGXGwcwSFkET0Dlbtc+1RmxSnDZRkAq\ngU90dm8K2E23Hfj5dXLZbamdIQKBgQDFqTj+SJ/YUwDfTcxoQ8lVnAefQLQL8MOA\nRplHPYUyYUZhme1KuRJ0Wm3n33ShiQ7nDfbJaSOKQv5CnpE1dVhTEkgFneg5xep5\nQlXrKqtVwL2PK5WcFgRB9Y5f70er3bRBvmgVES/Pd1NpAHzwSmAtAVMp7OmRi7r9\nHHLNOcsz1wKBgCRNKn1KTPIsGOg5DfSUBY81Z+loaPjHqoRSY5Ga5haVZ+HAyA5u\nxoObvMHEai99VTkDtAmdOV8azM8BfmYN+gFRbl52qKz90GkSMOTxRBuRSd4x3rVl\nkHQHIau5kK8k5DB/7sHO3QU2rxkvESsZwQxdgWCKzhkSzm+juwZ3Fz/hAoGBAKeQ\na7Z1zrxOsWCczXpebOHcYkHJUlkFBFdMgkh4iOBKwqWfHiDIgDKPLrjxICiIzk9l\n8R6RuQVPAclsL2GIVxYlW1UXpnTDqaCeccPo6lLKEGi85BnsODPKfaYqbTHvww4w\n4n9pkIRqfhV3ynLSOnIsu1nBc8hlEmHcqh38rp0FAoGAAPcFahjYDVRuu3SB+fSO\nssXnSRnzR2Vx4Rkm8EXDtZif+kCmQG74dMEqWMjrkTOL1kNkp4a4nnxQT1jJCEFf\nTFyxjByv/FTWilTU15euoRRvoZj755qP7nyXFdTPfZOjrLTX69dKk2xaudY/sztL\niPrvtAzZbISVnfc+gYbiTg0=\n-----END PRIVATE KEY-----\n
ENV_VARS=$(grep -v '^#' .env | grep -v 'GOOGLE_PRIVATE_KEY' | xargs | sed 's/ /,/g')

# update requirements
pip install -r requirements.txt > /dev/null 2>&1

# deploy command
gcloud run deploy $SERVICE_NAME \
    --source .                  \
    --region $REGION            \
    --set-env-vars $ENV_VARS    \
    --set-env-vars GOOGLE_PRIVATE_KEY=your_hardcoded_private_key \
    --allow-unauthenticated
