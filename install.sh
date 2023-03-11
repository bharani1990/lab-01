echo "Removing docker if installed...."
sudo apt-get -y remove docker docker-engine docker.io containerd runc

echo "Updating..."
sudo apt-get -y update && sudo apt-get -y upgrade

echo "Installing docker dependencies"
sudo apt-get -y install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

echo "Installing dockers official GPG key..."
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "Adding docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Updating..."
sudo apt-get -y update

echo "Installing docker...."
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Running post-install steps..."
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
