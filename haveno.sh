#!/bin/bash

# Fancy intro
clear
echo "===================================================="
echo "██╗  ██╗ █████╗ ██╗   ██╗███████╗███╗   ██╗ ██████╗ "   
echo "██║  ██║██╔══██╗██║   ██║██╔════╝████╗  ██║██╔════╝ "   
echo "███████║███████║██║   ██║█████╗  ██╔██╗ ██║██║  ███╗"
echo "██╔══██║██╔══██║██║   ██║██╔══╝  ██║╚██╗██║██║   ██║"
echo "██║  ██║██║  ██║╚██████╔╝███████╗██║ ╚████║╚██████╔╝"
echo "╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═══╝ ╚═════╝ "
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

# Step 4: Set execute permissions on the .deb file
log_info "Setting permissions for Haveno .deb file..."
sudo chmod +x haveno_amd64_deb-latest.deb &>> $logfile
if [ $? -ne 0 ]; then
  log_error "Failed to set permissions!"
  exit 1
fi
progress_bar 80
sleep 1

# Step 5: Install Haveno using dpkg
log_info "Installing Haveno package..."
sudo dpkg -i haveno_amd64_deb-latest.deb &>> $logfile
if [ $? -ne 0 ]; then
  log_error "Failed to install Haveno package!"
  exit 1
fi
progress_bar 100
sleep 1

# Final message
echo "===================================================="
echo "Installation Complete! You can find Haveno under Internet -> Haveno."
echo "Check the log file ($logfile) for details."
echo "===================================================="
