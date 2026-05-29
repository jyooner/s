#!/bin/bash

# Ensure any interrupted packages are configured
sudo dpkg --configure -a

# 1. Create the user 'robocamp' if they don't exist
if ! id "robocamp" &>/dev/null; then
    sudo useradd -m -s /bin/bash robocamp
    echo "robocamp:robocamp" | sudo chpasswd
    sudo usermod -aG sudo robocamp
fi

# 2. Update and install Chromium Browser
sudo apt update
sudo apt install chromium-browser -y

# 3. Automatically enable Experimental Web Platform Features via Policy
# This ensures it is permanently enabled for the robocamp user without relying only on CLI flags.
sudo mkdir -p /etc/chromium-browser/policies/managed

cat <<EOF | sudo tee /etc/chromium-browser/policies/managed/experimental_features.json > /dev/null
{
  "CommandLineFlagSecurityWarningsEnabled": false,
  "EnabledPlugins": ["ExperimentalWebPlatformFeatures"]
}
EOF

# 4. Launch Chromium AS the robocamp user with the flag explicitly passed
# We use 'sudo -H -u' to ensure the user's HOME directory environment variable is set correctly.
sudo -H -u robocamp chromium-browser --enable-experimental-web-platform-features &
