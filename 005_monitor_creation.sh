echo " *** AWX Deployment - Monitor deployment ***"
retry=0
kubectl config set-context --current --namespace=awx
logexpression="((?<=logger).*KubeAPIWarningLogger.*msg.*unknown field.*ansibleResult.*)"
while [[ ! $log_result=~$logexpression && $retry -lt 1000 ]]; do
    log_result=`kubectl logs --follow=false deployments/awx-operator-controller-manager -c awx-manager | tail -n 1`
    echo $log_result
    retry=$((retry+1))
done
echo "sleep for 5 min"
sleep 300
