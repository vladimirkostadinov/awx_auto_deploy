echo " *** AWX Deployment - Create Start Up script ***"
#this must be executed as root
cat <<EOF > /home/$AWX_SVC_USER/start_awx.sh
retry=0
while [ \$retry -lt 60 ]; do
    echo "Switch to AWX context" >> /home/$AWX_SVC_USER/start_awx.log 
	kubectl config set-context --current --namespace=awx >> /home/$AWX_SVC_USER/start_awx.log
    echo "Create Port forwarding ..." >> /home/$AWX_SVC_USER/start_awx.log
	kubectl port-forward service/awx-server-service --address 0.0.0.0 8080:80 >> /home/$AWX_SVC_USER/start_awx.log
	sleep 20
	retry=$((retry+1))
done
EOF

echo "Assign permissions over the startup script"
chmod +x /home/$AWX_SVC_USER/start_awx.sh

echo "Create cron job"
crontab -l > cron_file
echo "@reboot su $AWX_SVC_USER /home/$AWX_SVC_USER/start_awx.sh" >> cron_file
crontab cron_file
