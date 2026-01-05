#!/bin/bash

# Define variables
SMB_USER="TODO" # Replace with actual username
SMB_PASS="TODO" # Replace with actual password
SMB_IP="TODO" # Replace with actual password
SMB_SHARE="work1"
MOUNT_POINT="$HOME/work1"
CRED_FILE="/etc/samba/.credential"
FSTAB_BAK="/etc/fstab.bak"

echo "Starting CIFS mount setup..."

# 1. Create Samba Credential file
# Ensure the directory exists
sudo mkdir -p /etc/samba

echo "Creating credential file..."
sudo bash -c "cat > $CRED_FILE" <<EOF
username=$SMB_USER
password=$SMB_PASS
EOF

# Set permissions to root only for security
sudo chmod 600 $CRED_FILE

# 2. Create Mount Point
if [ ! -d "$MOUNT_POINT" ]; then
    echo "Creating mount point: $MOUNT_POINT"
    mkdir -p "$MOUNT_POINT"
fi

# 3. Backup /etc/fstab before modification
sudo cp /etc/fstab "$FSTAB_BAK"
echo "Backup of /etc/fstab created at $FSTAB_BAK"

# 4. Add entry to /etc/fstab if it doesn't exist
FSTAB_ENTRY="//$SMB_IP/$SMB_SHARE $MOUNT_POINT cifs credentials=$CRED_FILE,iocharset=utf8,x-systemd.automount 0 0"

if ! grep -q "//$SMB_IP/$SMB_SHARE" /etc/fstab; then
    echo "Adding entry to /etc/fstab..."
    echo "$FSTAB_ENTRY" | sudo tee -a /etc/fstab
else
    echo "Entry already exists in /etc/fstab. Skipping..."
fi

# 5. Reload daemon and mount
echo "Reloading daemon and mounting..."
sudo systemctl daemon-reload
sudo mount -a

# 6. Verify mount and remove backup if successful
if mountpoint -q "$MOUNT_POINT"; then
    echo "Mount successful! Removing backup file..."
    sudo rm "$FSTAB_BAK"
    df -h | grep "$SMB_SHARE"
else
    echo "Mount failed. Please check /etc/fstab. Backup preserved at $FSTAB_BAK"
    exit 1
fi

echo "Setup Complete."
