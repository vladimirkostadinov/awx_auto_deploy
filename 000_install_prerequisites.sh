source ./_variables.sh

echo " *** AWX Deployment - Install prerequisites *** "
echo "Install prerequisites - ca-certificates curl gnupg libssl-dev git make "
sudo apt-get -y install ca-certificates curl gnupg libssl-dev git make
echo "Create New user - adminawx"
sudo adduser adminawx --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
echo "adminawx:$AWX_SVC_PASS" | sudo chpasswd
echo "Add user adminawx to sudo group"
usermod -aG sudo adminawx

