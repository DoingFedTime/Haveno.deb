#!/bin/bash

clear
echo "               +++++++++++++++               "            
echo "           +++++++++++++++++++++++           "
echo "        +++++++++++++++++++++++++++++        "
echo "      +++++++++++++++++++++++++++++++++      "
echo "    +++++++++++++++++++++++++++++++++++++    "
echo "   +++++++++++++++++++++++++++++++++++++++   "
echo "  +++++++++++++++++++++++++++++++++++++++++  "
echo " ++++++++  +++++++++++++++++++++++  ++++++++ "
echo "+++++++++    +++++++++++++++++++    +++++++++"
echo "+++++++++      ++++++++++++++++     +++++++++"
echo "+++++++++       +++++++++++++       +++++++++"
echo "+++++++++         +++++++++         +++++++++"
echo "+++++++++   ##      +++++      ##   +++++++++"
echo "+++++++++   ####      +      ####   +++++++++"
echo "+++++++++   ######         ######   +++++++++"
echo "+++++++++   ########     ########   +++++++++"
echo "            ########## ##########            "
echo "            #####################            "
echo "   #######################################   "
echo "    #####################################    "
echo "      #################################      "
echo "        #############################        "
echo "           #######################           "
echo "              ###############                "
echo "=========================================================="
echo "                   HAVENO XMR Installer"
echo "               Privacy-First | Secure | Decentralized"
echo "=========================================================="
echo "KYC: Know Your Chains"
echo "===================================================="
echo "Starting installation... Hacker Mode: ON"
echo "===================================================="
# Function for logging
logfile="install_haveno.log"
echo "Installation log - $(date)" > $logfile

log_error() {
  echo "[ERROR] $1" | tee -a $logfile
}

log_info() {
  echo "[INFO] $1" | tee -a $logfile
}

# Progress bar
progress_bar() {
  local percentage=$1
  local progress=$(printf "%-${percentage}s" "#" | tr " " "#")
  echo -ne "[${progress:0:50}] ${percentage}%\r"
}

# Installation steps with error handling and progress updates

# Step 1: Download Haveno package
log_info "Downloading Haveno package..."
wget https://github.com/retoaccess1/haveno-reto/releases/latest/download/haveno_amd64_deb-latest.zip &>> $logfile
if [ $? -ne 0 ]; then
  log_error "Failed to download Haveno package!"
  exit 1
fi
progress_bar 20
sleep 1

# Step 2: Install dependencies
log_info "Installing dependencies..."
sudo apt install -y unzip libpcre3 &>> $logfile
if [ $? -ne 0 ]; then
  log_error "Failed to install dependencies!"
  exit 1
fi
progress_bar 40
sleep 1

# Step 3: Unzip the downloaded package
log_info "Unzipping the Haveno package..."
unzip haveno_amd64_deb-latest.zip &>> $logfile
if [ $? -ne 0 ]; then
  log_error "Failed to unzip the Haveno package!"
  exit 1
fi
progress_bar 60
sleep 1

# Step 4: Install Haveno using dpkg
log_info "Installing Haveno package..."
# Ensure the correct .deb file is used
if [ -f haveno_1.0.11-1_amd64.deb ]; then
  sudo dpkg -i haveno_1.0.11-1_amd64.deb &>> $logfile
  if [ $? -ne 0 ]; then
    log_error "Failed to install Haveno package!"
    exit 1
  fi
else
  log_error "Haveno .deb file not found after unzipping!"
  exit 1
fi
progress_bar 100
sleep 1

# Final message
echo "=========================================================="
echo "Haveno installation complete! XMR for the win! 🎉"
echo "You can find Haveno under Internet -> Haveno."
echo "Check the log file ($logfile) for details."
echo "=========================================================="
