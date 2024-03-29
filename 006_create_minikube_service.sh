echo " *** AWX Deployment - Create Minikube Service *** "
source ./_variables.sh

cat  <<EOF > /usr/lib/systemd/system/minikube.service
[Unit]
Description=minikube
After=network-online.target firewalld.service containerd.service docker.service
Wants=network-online.target docker.service
Requires=docker.socket containerd.service docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/home/$AWX_SVC_USER
ExecStart=/usr/local/bin/minikube start
ExecStop=/usr/local/bin/minikube stop
User=$AWX_SVC_USER
Group=sudo

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload 
systemctl enable minikube
systemctl start minikube
