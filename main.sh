#!/bin/bash
sudo dpkg --configure -a
# 1. Create the user
sudo useradd -m -s /bin/bash robocamp

# 2. Set the password
echo "robocamp:robocamp" | sudo chpasswd

# 3. Add robocamp to the sudo group so it actually has permission to install things
sudo usermod -aG sudo robocamp

# 4. Run the installations AS the robocamp user
sudo -u robocamp sudo apt update
sudo -u robocamp sudo apt install chromium-browser -y

# Note: Google Chrome is usually not in the default apt repositories for Pop!_OS. 
# If you meant to launch Chrome with that flag *after* installing Chromium, use this:
sudo -u robocamp chromium-browser --enable-experimental-web-platform-features &
