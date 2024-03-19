#!/bin/bash

# Check if Samba is installed, if not, install it
if ! dpkg -s samba &> /dev/null; then
    echo "Samba is not installed. Installing..."
    sudo apt update
    sudo apt install -y samba
fi

# Create a backup of the original smb.conf file
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak

# Define the share configuration for the Videos folder
sudo tee -a /etc/samba/smb.conf > /dev/null <<EOT

[Videos]
   comment = Share for Videos
   path = ~/home/wes/Videos
   browseable = yes
   read only = no
   guest ok = yes
   create mask = 0777
   directory mask = 0777
EOT

# Replace /path/to/your/Videos/folder with the actual path to your Videos folder

# Restart the Samba service to apply the changes
sudo systemctl restart smbd

echo "Videos folder is now set up as a shareable folder."
