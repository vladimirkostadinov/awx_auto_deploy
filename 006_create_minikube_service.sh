echo " *** AWX Deployment - Create Minikube Service *** "

#this must be executed as root
cat  <<EOF > /usr/lib/systemd/system/minikube.service
[Unit]
Description=minikube
After=network-online.target firewalld.service containerd.service docker.service
Wants=network-online.target docker.service
Requires=docker.socket containerd.service docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/home/adminawx
ExecStart=/usr/local/bin/minikube start
ExecStop=/usr/local/bin/minikube stop
User=adminawx
Group=sudo

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload 
systemctl enable minikube
systemctl start minikube