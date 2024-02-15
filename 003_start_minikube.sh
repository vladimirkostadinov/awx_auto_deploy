echo " *** AWX Deployment - Start Minikube *** "
source ./_variables.sh
minikube start --cpus=$AWX_CPU --memory=$AWX_RAM --addons=ingress

kubectl version
minikube status
kubectl get nodes
kubectl get pods -A

