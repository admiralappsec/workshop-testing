# clone branch locally
git clone -b initial-app https://github.com/admiralappsec/workshop-testing.git

# move into the main directory following clone
cd workshop-testing

# build application using maven wrapper
mvnw clean package -DskipTests -Denv=cloud

# log into azure cli
az login --service-principal -u "${AZURE_APPLICATION_ID}" -p "${AZURE_CLIENT_SECRET}" --tenant "${AZURE_TENANT_ID}";

# set default subscription
az account set --subscription "${AZURE_SUBSCRIPTION_ID}";

# configure additional defaults for azure cli
az configure --defaults group="${AZURE_RESOURCE_GROUP_NAME}" spring-cloud="${AZURE_SP_SERVICE_NAME}";

# create an application on the Azure Spring Cloud PaaS
az spring-cloud app create --name ${APP_NAME} --instance-count 1 --is-public true --memory 2 --jvm-options='-Xms2048m -Xmx2048m' --enable-persistent-storage true

# deploy application JAR into Azure Spring Cloud application
az spring-cloud app deploy --name ${APP_NAME} --jar-path ${APP_JAR}

# show url of deployed application
az spring-cloud app show --name ${APP_NAME} | grep url

