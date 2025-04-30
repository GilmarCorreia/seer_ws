#!/bin/bash

# SEER Setup
source $SEER_DIR/seer.sh

# Creating seer_ws (ROS2 workspace) folder
cd $SEER_DIR

# Cloning github repositories
git clone --recurse-submodules git@github.com:CDC-IA/seer_ws.git -b linux
cd $SEER_WS_DIR
git config --global --add safe.directory $SEER_WS_DIR
bash init_submodules.sh

# Building imported ros packages
cd $SEER_WS_DIR
colcon build

# SEER source
seer_text="
# SEER Setup
source $SEER_DIR/seer.sh"

sudo echo "$seer_text" >> ~/.bashrc

# Final message
echo "ROS2 Humble Workspace configured"