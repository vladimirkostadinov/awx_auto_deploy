source ./_variables.sh

echo "*** Apply AWX configuration ***"
echo "Create kustomization.yaml file"
cat  <<EOF > ./kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - github.com/ansible/awx-operator/config/default?ref=$AWX_VERSION
images:
  - name: quay.io/ansible/awx-operator
    newTag: $AWX_VERSION
namespace: awx
EOF

echo " *** AWX Deployment - Apply minikube configuration"
kubectl apply -k .

sleep 120

## create docker.io credentials for pulling POSTGRESQL docker image
#DOCKERHUB_USERNAME=vladimirkst
#DOCKERHUB_PASSWORD=K0st@d1n0v

echo "Create docker.io credentials with name awx-registry-secret for pulling POSTGRESQL docker image"
kubectl -n awx create secret docker-registry awx-registry-secret \
    --docker-server=docker.io \
    --docker-username=${DOCKERHUB_USERNAME} \
    --docker-password=${DOCKERHUB_PASSWORD}
echo "Set permissions over default service account for pulling requests with awx-registry-secret"
kubectl -n awx patch serviceaccount default -p '{"imagePullSecrets": [{"name": "awx-registry-secret"}]}'

echo "Navigate to awx created namespace"
kubectl config set-context --current --namespace=awx

# create awx-server.yaml config file and point docker creds
echo "Create awx-server.yaml config file and point image pull creds with name awx-registry-secret"
cat  <<EOF > ./awx-server.yaml
---
apiVersion: awx.ansible.com/v1beta1
kind: AWX
metadata:
  name: awx-server
spec:
  service_type: nodeport
  replicas: 1
  image_pull_secret: awx-registry-secret
EOF

echo "Update kustomization.yaml file - add awx-server.yaml config file"
cat  <<EOF > ./kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - github.com/ansible/awx-operator/config/default?ref=$AWX_VERSION
  - awx-server.yaml
images:
  - name: quay.io/ansible/awx-operator
    newTag: $AWX_VERSION
namespace: awx
EOF

echo "Apply consolidated configuration ..."
kubectl apply -k .