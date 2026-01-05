#!/bin/bash

# Define variables
SMB_USER="TODO" # Replace with actual username
SMB_PASS="TODO" # Replace with actual password
SMB_IP="TODO" # Replace with actual IP
SMB_SHARE="work1"
MOUNT_POINT="$HOME/work1"
CRED_FILE="/etc/samba/.credential"
FSTAB_BAK="/etc/fstab.bak"

# Get current user's UID and GID to fix root permission issue
CURRENT_UID=$(id -u)
CURRENT_GID=$(id -g)

echo "Starting CIFS mount setup with User Permissions..."

# 1. Check and install cifs-utils if not present
if ! dpkg -l | grep -q cifs-utils; then
    echo "cifs-utils not found. Installing..."
    sudo apt-get update
    sudo apt-get install -y cifs-utils
else
    echo "cifs-utils is already installed."
fi

# 2. Create Samba Credential file
sudo mkdir -p /etc/samba
echo "Creating credential file..."
sudo bash -c "cat > $CRED_FILE" <<EOF
username=$SMB_USER
password=$SMB_PASS
EOF
sudo chmod 600 $CRED_FILE

# 3. Create Mount Point
if [ ! -d "$MOUNT_POINT" ]; then
    echo "Creating mount point: $MOUNT_POINT"
    mkdir -p "$MOUNT_POINT"
fi

# 4. Backup /etc/fstab
sudo cp /etc/fstab "$FSTAB_BAK"

# 5. Add entry to /etc/fstab with uid and gid options
# Added uid=$CURRENT_UID and gid=$CURRENT_GID to grant write permissions to the user
FSTAB_ENTRY="//$SMB_IP/$SMB_SHARE $MOUNT_POINT cifs credentials=$CRED_FILE,uid=$CURRENT_UID,gid=$CURRENT_GID,iocharset=utf8,x-systemd.automount 0 0"

if ! grep -q "//$SMB_IP/$SMB_SHARE" /etc/fstab; then
    echo "Adding entry to /etc/fstab with ownership for UID: $CURRENT_UID..."
    echo "$FSTAB_ENTRY" | sudo tee -a /etc/fstab
else
    # If entry exists, replace it to update permissions
    echo "Updating existing entry in /etc/fstab..."
    sudo sed -i "\|//$SMB_IP/$SMB_SHARE|d" /etc/fstab
    echo "$FSTAB_ENTRY" | sudo tee -a /etc/fstab
fi

# 6. Reload and remount
echo "Reloading daemon and remounting..."
sudo systemctl daemon-reload
sudo umount "$MOUNT_POINT" 2>/dev/null
sudo mount -a

# 7. Verify mount and permissions
if mountpoint -q "$MOUNT_POINT"; then
    echo "Mount successful! Ownership assigned to $(whoami)."
    sudo rm "$FSTAB_BAK"
    ls -ld "$MOUNT_POINT"
else
    echo "Mount failed. Restoring backup..."
    sudo mv "$FSTAB_BAK" /etc/fstab
    exit 1
fi

echo "Setup Complete."
