source ./common.sh
./000_install_prerequisites.sh
./001_install_docker.sh
./002_install_minikube.sh
su adminawx ./003_start_minikube.sh
su adminawx ./004_apply_awx_config.sh
su adminawx ./005_monitor_creation.sh
./006_create_minikube_service.sh
./007_create_start_up_script.sh
su adminawx ./008_output_ui_password.sh
