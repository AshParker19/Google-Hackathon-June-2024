# Google-Hackathon-June-2024

## Project link --> https://sublime-lyceum-426907-r9-t3tir7yoea-ew.a.run.app/

---
## How to deploy the project on Google Cloud:
1. Install Google Cloud CLI for your OS: https://cloud.google.com/sdk/docs/install.
   
     (You can check if it's installed by running `gcloud --version` in the terminal.)
2. Activate it according to the OS's instructions.
3. Go to the project's root directory and do the following steps:
    1. `gcloud init`.
    2. Log in with your Google account.  In our case, Oksana owns the project so you need her account to access it.
    3. Choose the project you want to deploy the app to.
4. `chmod +x ./deploy.sh`
5. `./deploy.sh`

---
### How to stop the server:
1. Check the name of the active service: `gcloud app services list`.
2. Stop the service: `gcloud app services stop SERVICE_NAME`.
