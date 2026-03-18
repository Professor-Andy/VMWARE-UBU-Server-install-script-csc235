sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc | cut -f1)
# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
sudo usermod -aG docker $USER
newgrp docker
docker compose version
docker run --rm hello-world | grep -q "Hello" && echo -e "\033[92mSuccess\033[0m" || echo -e "\033[31mFailure\033[0m"
sudo apt install open-vm-tools open-vm-tools-desktop
sudo mkdir -p /mnt/share
ln -s /mnt/share /home/student/share
echo ".host:/Share   /mnt/share   fuse.vmhgfs-fuse   defaults,allow_other   0   0" | sudo tee -a /etc/fstab
shutdown -r now
