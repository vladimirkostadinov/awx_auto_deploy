echo " *** AWX Deployment - Install Minikube *** "
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube version
alias kubectl="minikube kubectl --"
sudo ln -s $(which minikube) /usr/local/bin/kubectl

