# New-app-w-github-action branch..

This branch contains the new PotClinic application source code along with the github action assocaited with deploying the application with a Contrast Java Agent onto the Azure Spring Cloud PaaS environment

Contrast Security Azure Spring Cloud Github Action Use:

```sh
- name: Contrast Security Azure Spring Cloud Deployment
        uses: admiralappsec/springone-github-action@v1.3
        id: contrast-deployment
        with:
          application-name: <SPRING CLOUD APPLICATION NAME>
          spring-cloud-service-name: <SPRING CLOUD SERVICE NAME>
          application-artifact-location: <DEPLOYABLE ARTIFACT - JAR> #relative to '/github/workspace/'
          contrast-security-credentials-file: ${{ secrets.CONTRAST_CREDS_FILE }}
          azure-credentials-file: ${{ secrets.AZURE_CREDS_FILE }}
          github-developer-token: ${{ secrets.GITHUB_DEV_TOKEN }}
```
