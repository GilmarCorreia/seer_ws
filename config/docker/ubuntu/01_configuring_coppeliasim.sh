#!/bin/bash

# installing pip packages
python3 -m pip install -U pip
pip install pyzmq cbor2 xmlschema coppeliasim-zmqremoteapi-client psutil pympler numpy==1.24 pandas

# choosing coppelia sim version
coppeliasim_version="V4_7_0_rev4"

# Downloading coppelia sim
cd $SEER_DIR
mkdir Downloads
cd $SEER_DIR/Downloads

wget https://downloads.coppeliarobotics.com/${coppeliasim_version}/CoppeliaSim_Edu_${coppeliasim_version}_Ubuntu22_04.tar.xz
tar -xvf CoppeliaSim_Edu_${coppeliasim_version}_Ubuntu22_04.tar.xz

rm -r CoppeliaSim_Edu_${coppeliasim_version}_Ubuntu22_04.tar.xz