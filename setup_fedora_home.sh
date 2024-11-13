#!/bin/bash

# Variables (replace these with actual values)
FEDORA_HOME_PARTITION="/dev/sdXN"  # Replace with Fedora home partition
FEDORA_USER="your_fedora_user"     # Replace with Fedora username
FEDORA_MOUNT_POINT="/mnt/fedora_home"
UBUNTU_HOME="$HOME"

# Step 1: Create the mount point and mount Fedora's home directory
echo "Creating mount point at $FEDORA_MOUNT_POINT and mounting Fedora home directory..."
sudo mkdir -p $FEDORA_MOUNT_POINT
sudo mount $FEDORA_HOME_PARTITION $FEDORA_MOUNT_POINT

# Step 2: Link Fedora's .bashrc and .bash_profile to Ubuntu's home directory
echo "Linking Fedora's .bashrc and .bash_profile to Ubuntu's home directory..."
ln -sf "$FEDORA_MOUNT_POINT/$FEDORA_USER/.bashrc" "$UBUNTU_HOME/.bashrc"
ln -sf "$FEDORA_MOUNT_POINT/$FEDORA_USER/.bash_profile" "$UBUNTU_HOME/.bash_profile"

# Step 3: Add Fedora's custom binaries to PATH (optional)
echo "Adding Fedora's bin directory to PATH in Ubuntu's .bashrc..."
echo 'export PATH=$PATH:'"$FEDORA_MOUNT_POINT/$FEDORA_USER/bin" >> "$UBUNTU_HOME/.bashrc"

# Step 4: Create an alias to load Fedora's environment on demand
echo "Adding an alias 'fedora_env' to load Fedora's environment on demand..."
echo "alias fedora_env='source $FEDORA_MOUNT_POINT/$FEDORA_USER/.bashrc'" >> "$UBUNTU_HOME/.bashrc"

# Step 5: Update /etc/fstab to auto-mount Fedora's home partition on boot
echo "Adding Fedora's home partition to /etc/fstab for auto-mounting..."
UUID=$(sudo blkid -s UUID -o value $FEDORA_HOME_PARTITION)
echo "UUID=$UUID $FEDORA_MOUNT_POINT ext4 defaults 0 2" | sudo tee -a /etc/fstab

# Finish
echo "Setup complete. Please restart the terminal or run 'source ~/.bashrc' to apply changes."
