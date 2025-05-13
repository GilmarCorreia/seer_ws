#!/bin/bash

# Sim Setup
source $SIM_DIR/sim.sh

# Creating sim_ws (ROS2 workspace) folder
cd $SIM_DIR

# Cloning github repositories
git clone --recurse-submodules https://github.com/GilmarCorreia/sim_ws.git -b main
cd $SIM_WS_DIR
git config --global --add safe.directory $SIM_WS_DIR
bash init_submodules.sh

# Building imported ros packages
cd $SIM_WS_DIR
colcon build

# sim source
sim_text="
# Sim Setup
source $Sim_DIR/sim.sh"

sudo echo "$sim_text" >> ~/.bashrc

# Final message
echo "ROS2 Humble Workspace configured"