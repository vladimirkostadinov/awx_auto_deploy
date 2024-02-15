# AWX Ansible auto-installation on Ubuntu server 20.4

## Installation

1. Clone or copy the folder on target server (the automation is tested on Ubuntu server)

2. Update _variables.sh file with proper values for :
  
    - Docker Hub account and password (it's required for pulling PostGreSQL docker image) - ```DOCKERHUB_USERNAME``` and ```DOCKERHUB_PASSWORD```
    - AWX Controller version - ```AWX_VERSION```
    - Number of dedicated CPUs for AWX minikube's docker container - ```AWX_CPU```
    - Dedicated RAM for AWX minikube's docker container - ```AWX_RAM```
    - AWX service account user name - ```AWX_SVC_USER```
    - AWX service account password - ```AWX_SVC_PASS```
  
    > *📝* Important Note: This AWX service account will be created during installation. It will be used only for minikube  interaction and it's responsible for running port forwarding of AWX GUI and running AWX service and cronjob. The administration account for AWX GUI login is with user name "admin". The password will be shown in the bash console when installation is done or it can be retrived from minikube secret vault. 

3. Assign executable, read and write permissions on top folder and all files in the folder for root user
   > *📝* Note: Root user is required for creating new service for minikube and creating hard link for minikube  


4. Navigate to the top folder and run ```./install.sh``` file as root user
