echo " *** AWX Deployment - Start Minikube *** "

minikube start --cpus=4 --memory=12g --addons=ingress

kubectl version
minikube status
kubectl get nodes
kubectl get pods -A

