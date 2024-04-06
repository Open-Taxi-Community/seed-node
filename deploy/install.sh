#!/bin/bash

# Check if the script is running as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

# Download Go
GO_VERSION=go1.22.0 # Make sure to use the latest version
wget https://golang.org/dl/${GO_VERSION}.linux-amd64.tar.gz -O /tmp/go.tar.gz

# Remove any previous installation
rm -rf /usr/local/go

# Extract Go to /usr/local
tar -C /usr/local -xzf /tmp/go.tar.gz

# Clean up
rm /tmp/go.tar.gz

# Set up Go PATH for all users
# Add Go to the PATH in /etc/profile (for shell login)
if ! grep -q "/usr/local/go/bin" /etc/profile; then
  echo "export PATH=\$PATH:/usr/local/go/bin" >> /etc/profile
fi

export PATH=$PATH:/usr/local/go/bin
go build -o /usr/local/bin/seed-node ./cmd/seed-node
sudo chmod +x /usr/local/bin/seed-node
sudo chown seed-node:seed-node /usr/local/bin/seed-node
echo "Go installation is complete. Please restart your shell or re-login to apply PATH changes."

# Create a group for the seed-node if it doesn't already exist
if getent group seed-node >/dev/null; then
  echo "Group seed-node already exists."
else
  groupadd seed-node
  echo "Group seed-node created."
fi

# Create a user for the seed node service if it doesn't already exist
if id "seed-node" &>/dev/null; then
  echo "User seed-node already exists."
else
  useradd -r -m -d /var/lib/seed-node -s /bin/false -g seed-node seed-node
  echo "User seed-node created and added to group seed-node."
fi

chown seed-node:seed-node /var/lib/seed-node
chmod 770 /var/lib/seed-node
echo "User seed-node has been set up."

sudo cp packaging/systemd/seed-node.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable seed-node.service
sudo systemctl start seed-node.service

read -p "Installation requires a reboot to complete. Proceed? (y/n) " -n 1 -r
echo    # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo reboot
else
    echo "Please reboot your system manually to complete installation."
fi
