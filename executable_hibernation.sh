#!/bin/bash
# allows quick removal and addition of a swapfile

if [[ $EUID != 0 ]]; then
    echo "must be run as root"
    exit 1
fi

if [ $1 == "enable" ]; then
  #swapoff /swapfile
  #rm -f /swapfile
  #dd if=/dev/zero of=/swapfile bs=1M count=8k status=progress
  chmod 0600 /swapfile
  mkswap -U clear /swapfile
  swapon /swapfile
  #mkinitcpio -P
  /home/waverider/hibernator
elif [ $1 == "disable" ]; then
  swapoff /swapfile
  /usr/bin/rm -f /swapfile

  # thanks chatgpt for this code lmao :3

  # START CHATCPT CODE

  # Backup the original file
  cp /etc/default/grub /etc/default/grub.bak
  
  # Use sed to edit the file in-place
  sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT=/ s/\<resume=[^ ]*//g' /etc/default/grub
  sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT=/ s/\<resume_offset=[^ ]*//g' /etc/default/grub
  
  # Remove any extra spaces that might be left
  sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT=/ s/  */ /g' /etc/default/grub
  
  # Ensure the line ends with a double quote
  sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT=/ { /"$/! s/$/"/ }' /etc/default/grub
  # Ensure no trailing space before the closing quote
  sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT=/ s/ \+"/"/' /etc/default/grub

  # END OF CHATGPT CODE

  #mkinitcpio -P
  update-grub
else
  echo "Unreconized paramater: ${1}"
  echo "Usage: hibernation.sh <enable|disable>"
fi
