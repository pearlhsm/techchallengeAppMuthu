# Muthu Chelliah Assessment submission

Git Repo: pearlhsm/techchallengeapp-kubectl-tf-az-devops

# Techchallenge Application Architecture

![image](https://user-images.githubusercontent.com/88908606/175812090-fba66ddb-5e14-422a-96d8-f88a2b97ffd6.png)



# Terminologies used to deploy this application into cloud

Cloud Platform  : Azure Cloud
Image build     : Docker 
Orchestration   : Kubernetes using AKS
Provisioning    : HashiCorp Terraform
Language        : Shell script and YAML 
CI/CD           : Azure DevOps
Database        : Postgresql server 

# Folder and files are created/updated

![image](https://user-images.githubusercontent.com/88908606/175813073-0c65f313-df10-4156-a9e6-08aab0ca00a4.png)



script.sh  under root (created) to execute techchallenge update -s and then serve.

Dockerfile under root (updated) to execute the script.sh

deployment.yml under root (created) to deploy kubernetes deployment into kubernetes cluster.

*.tf under kubernetes folder (created) to provision k8s cluster and postgres database server v11(Inclusding databse name: app).

ci-cd-provision.yml under root (created) to automate provisioning k8s cluster and postgres database server v11(Inclusding databse name: app).

cd-cd-deployment.yml under root (created) to automate deploy kubernetes deployment file into kubernetes cluster.

# Servian Technical Challenge High level steps

High level Steps to deploy the application into Azure Cloud

Shell script is used to create the prelaunch script to execute techchallenge update -s and then serve (filename: script.sh). 

create docker Image using docker file and upload into docker hub  (Image name in Docker hub: pearlhsm/techchallenge:v1).

Create kubernetes Deployment file for deploy container instances in Kubernetes cluster (filename: deployment.yml).

Create HashiCorp Terraform coding to provision AKS Kubernetes cluster and postgresql server in Azure.

Automate provisioning k8s clusters, postgres database server and database using Azure DevOps CI/CD pipeline.

Automate the container instances deployment on k8s cluster using CI/CD pipeline using Azure DevOps.


## Solution

My solution will deploy the application into an empty cloud environment with no existing infrastructure in place.
There is no requirement for Servian to access your cloud environment to deploy this solution.

## My Git Repo

Git Repo: pearlhsm/techchallengeapp-kubectl-tf-az-devops

# Details steps (terminology wise)

# 1. Docker Image creation

Pre-requisites: Docker Desktop

Launch Script is created and placed it in git root folder to create table and then launch the application.(filename: script.sh) 
Updated the docker file to call script.sh file.
Create the docker Image and export into Docker registry. (Image name in Docker hub: pearlhsm/techchallenge:v1)

Tested the Image in: Windows docker Desktop

# 2. Kubernetes Deployment (Docker Image on Local machine)

Pre-requisites: Docker Desktop and enable to kubernetes to test docker Images

create kubernetes Deployment file using YAML language. 
single YAML file used for kubernetes deployment and services. (filename: deployment.yml) 
Deployment will pull the image from docker registry if not exists locally.
Service will use Azure standard loadbalancer and serve the application via port 3000.

Tested the image in Kubernetes cluster enabling Kubernetes in Docker Desktop.

# 3. AKS Kubernetes provisioning coding using HashiCorp Terraform

Pre-requisites: Terraform and Azure account

Create terraform code to provision AKS Kubernetes cluster Azure. 
Create terraform code to provision postgres server and database (DB name: app) in Azure.
Empty variables (Azure Client ID, secret and SSL key) are included in the code to provision resources in Azure. 
[Note: Variable values are added in the CI/CD pipeline explained in the later section]
Provisioned AKS Kubernetes clustes and resources by executing terraform in local machine before creating CI/CD pipeline.
Output.tf file provide postgres server name.

# 4. Automate AKS Kubernetes and database server provisioning via Azure DevOps CI/CD

Pre-requisites: 
Azure and DevOps account.
Terrafrom extentions are required to install, execute and run the commands.
 - Terraform 1 (https://marketplace.visualstudio.com/items?itemName=ms-devlabs.custom-terraform-tasks)
 - Terraform 2 (https://marketplace.visualstudio.com/items?itemName=charleszipp.azure-pipelines-tasks-terraform)

create service connection to Git to clone Git repository of Techchallange application.
create service connection to Azure cloud to provision resources in Azure Cloud.
create Techchallange project under the Azure DevOps organization.
create CI/CD pipeline under Techchallenge project. This is single pipeline (YAML file) execute Terraform file create AKS cluster and Database.
 - This pipeline contains variable values (SSL key) for the empty varibles added in the terraform files.
 - This pipeline will execute terraform commands to create AKS Kubernetes and database server (including database) provisioning.
 
 ![image](https://user-images.githubusercontent.com/88908606/177045113-197c8fca-7ee6-493b-8358-ee7d1e1de215.png)


Note: Manual step is required to enable firewall settings. Application connection will refused to create table while launching the application.

![image](https://user-images.githubusercontent.com/88908606/177045327-63200a3c-c3cc-4763-a09e-732a8f7322c1.png)

Copy postgress servers and admin username from Azure portal and update the Update kubernetes deployment file located in Git root directory

![image](https://user-images.githubusercontent.com/88908606/177045587-a9dfdcc5-9ef7-42c5-8da0-3694c744d306.png)

# 5. Automate container instances deployment in kubernetes cluster via Azure DevOps CI/CD

create kubernetes service connection to deploy the kubectl configuration file.
create second pipeline to under Techchallenge project. This is single pipeline (YAML file).
 - This pipeline publish the kubectl deployment file into Azure artifacts
 - This pipeline download the kubectl deployment file from Azure artifacts into target directory.
 - This deployment pull the docker image from docker registry and deploy it into Kuberbetes clusters and start serving the application.
 
 ![image](https://user-images.githubusercontent.com/88908606/177045491-abc06079-60e5-4777-974b-cc8c25ec197e.png)


# 6. Launch the servian application after Implementation



Now take IP address from the output of kubectl get svc loadbalancer and run it in the web browser (Example: http://IPaddress:3000 )






