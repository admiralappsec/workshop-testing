---
page_type: sample
description: "Deploy Java Spring Petclinic application using GitHub Actions"
products:
- GitHub Actions
- Azure App service
languages:
- Java
urlFragment: https://github.com/spring-projects/spring-petclinic
---

# Deploying a Java Web App using GitHub actions

Learn to deploy a Java Spring app to Azure App Service and set up a CI/CD workflow using GitHub Actions

## Overview

**GitHub Actions** gives you the flexibility to build an automated software development lifecycle workflow. You can write individual tasks ("Actions") and combine them to create a custom workflow. Workflows are configurable automated processes that you can set up in your repository to build, test, package, release, or deploy any project on GitHub.

With **GitHub Actions** you can build end-to-end continuous integration (CI) and continuous deployment (CD) capabilities directly in your repository. 

### Prerequisites

1. You will need a **GitHub** account. If you do not have one, you can sign up for free [here](https://github.com/join)

1. **Microsoft Azure Account**: You will need a valid and active Azure account for this lab. If you do not have one, you can sign up for a [free trial](https://azure.microsoft.com/en-us/free/).


### Setting up the GitHub repository

Fork this repo and open the sample app code in VS Code to get started.

## Create an Azure App Service

Create a web app hosted in Azure with a unique name, **Linux** as the OS and **Java 8** as the runtime and Tomcat 9 enabled . 

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2F201-web-app-java-tomcat%2Fazuredeploy.json" target="_blank">
    <img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png"/>
</a>

This template deploys a simple Linux Web Application with Java 8 and Tomcat 9 enabled allowing you to run Java applications in Azure.  

The WebPlan is settled for Consumption. For more information about [hosting Plans](https://azure.microsoft.com/pricing/details/app-service/linux) As a default, this template deploys the web app using the F1" (free tier) as the pricing tier for the hosting plan. It is ideal for development and test environments, for production environments you must consider different plans.

If you are new to Web App Services, see:

- [Web App](https://azure.microsoft.com/services/app-service/web)
- [Web App Documentation](https://docs.microsoft.com/azure/app-service/)
- [Template reference](https://docs.microsoft.com/azure/templates/microsoft.compute/allversions)

## Set up CI/CD workflow with GitHub Actions 

We'll use GitHub actions to automate our deployment workflow for this web app. 

1. Navigate to the sample CI/CD workflow file `workflow.yml` in your GitHub repo under `.github/workflows/` folder path

1. Modify the values of the environment variables based on your Azure app:
```yaml
env:
  AZURE_WEBAPP_NAME: your-app-name    # set this to your application's name
  AZURE_WEBAPP_PACKAGE_PATH: '.'      # set this to the path to your web app project, defaults to the repository root
  JAVA_VERSION: '1.8'                # set this to the Java version to use
  AZURE_WEBAPP_PUBLISH_PROFILE: ${{ secrets.AZURE_WEBAPP_PUBLISH_PROFILE }}     # set GH repo secret with the publish profile of the web app
```

1. In the portal, Overview page, click on "Get publish profile". A publish profile is a kind of deployment credential, useful when you don't own the Azure subscription. Open the downloaded settings file in VS Code and copy the contents of the file.

   ![](https://github.com/Azure/actions-workflow-samples/blob/master/assets/images/get-publish-profile.png)


1. We will now add the publish profile as a secret associated with this repo. On the GitHub repository, click on the "Settings" tab.

   ![](https://github.com/Azure/actions-workflow-samples/blob/master/assets/images/github-settings.png)


1. Go to "Secrets". Create a new secret called "AZURE_WEBAPP_PUBLISH_PROFILE" and paste the contents from the settings file.

   ![](https://github.com/Azure/actions-workflow-samples/blob/master/assets/images/create-secret.png)

1. Once you're done editing the workflow by configuring the required environment variables, click on "Start commit". Committing the file will trigger the workflow.

1. You can go back to the Actions tab, click on your workflow, and see that the workflow is queued or being deployed. Wait for the job to complete successfully.

1. Browse your app by pasting the URL of your Azure web app: https://AZURE_WEBAPP_NAME.azurewebsites.net

1. Make any changes by editing the app contents and commit the changes. Browse to the **Actions** tab in GitHub to view the live logs of your Action workflow which got triggered with the push of the commit.

1.  Once the workflow successfully completes execution, browse back to your website to visualise the new changes you introduced!

## Understanding the Spring Petclinic application with a few diagrams
<a href="https://speakerdeck.com/michaelisvy/spring-petclinic-sample-application">See the presentation here</a>

## Running petclinic locally
Petclinic is a [Spring Boot](https://spring.io/guides/gs/spring-boot) application built using [Maven](https://spring.io/guides/gs/maven/). You can build a jar file and run it from the command line:


```
git clone https://github.com/spring-projects/spring-petclinic.git
cd spring-petclinic
./mvnw package
java -jar target/*.jar
```

You can then access petclinic here: http://localhost:8080/

<img width="1042" alt="petclinic-screenshot" src="https://cloud.githubusercontent.com/assets/838318/19727082/2aee6d6c-9b8e-11e6-81fe-e889a5ddfded.png">

Or you can run it from Maven directly using the Spring Boot Maven plugin. If you do this it will pick up changes that you make in the project immediately (changes to Java source files require a compile as well - most people use an IDE for this):

```
./mvnw spring-boot:run
```

## In case you find a bug/suggested improvement for Spring Petclinic
Our issue tracker is available here: https://github.com/spring-projects/spring-petclinic/issues


## Database configuration

In its default configuration, Petclinic uses an in-memory database (HSQLDB) which
gets populated at startup with data. A similar setup is provided for MySql in case a persistent database configuration is needed.
Note that whenever the database type is changed, the app needs to be run with a different profile: `spring.profiles.active=mysql` for MySql.

You could start MySql locally with whatever installer works for your OS, or with docker:

```
docker run -e MYSQL_USER=petclinic -e MYSQL_PASSWORD=petclinic -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=petclinic -p 3306:3306 mysql:5.7.8
```

Further documentation is provided [here](https://github.com/spring-projects/spring-petclinic/blob/master/src/main/resources/db/mysql/petclinic_db_setup_mysql.txt).

## Working with Petclinic in your IDE

### Prerequisites
The following items should be installed in your system:
* Java 8 or newer.
* git command line tool (https://help.github.com/articles/set-up-git)
* Your preferred IDE 
  * Eclipse with the m2e plugin. Note: when m2e is available, there is an m2 icon in `Help -> About` dialog. If m2e is
  not there, just follow the install process here: https://www.eclipse.org/m2e/
  * [Spring Tools Suite](https://spring.io/tools) (STS)
  * IntelliJ IDEA
  * [VS Code](https://code.visualstudio.com)

### Steps:

1) On the command line
```
git clone https://github.com/spring-projects/spring-petclinic.git
```
2) Inside Eclipse or STS
```
File -> Import -> Maven -> Existing Maven project
```

Then either build on the command line `./mvnw generate-resources` or using the Eclipse launcher (right click on project and `Run As -> Maven install`) to generate the css. Run the application main method by right clicking on it and choosing `Run As -> Java Application`.

3) Inside IntelliJ IDEA

In the main menu, choose `File -> Open` and select the Petclinic [pom.xml](pom.xml). Click on the `Open` button.

CSS files are generated from the Maven build. You can either build them on the command line `./mvnw generate-resources`
or right click on the `spring-petclinic` project then `Maven -> Generates sources and Update Folders`.

A run configuration named `PetClinicApplication` should have been created for you if you're using a recent Ultimate
version. Otherwise, run the application by right clicking on the `PetClinicApplication` main class and choosing
`Run 'PetClinicApplication'`.

4) Navigate to Petclinic

Visit [http://localhost:8080](http://localhost:8080) in your browser.

## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
