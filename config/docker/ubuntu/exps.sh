#!/bin/bash

cd $SEER_WS_DIR/src/senai_models

model=mir100
simulator=gazebo
total_time=300
runs=5

scenes=( empty default obstacle static dynamic aisle )

for scene in "${scenes[@]}"; do
	for i in $(seq 1 $runs); do
		./launch.sh $model $scene $simulator $total_time pure_pursuit_control
		sleep 10
	done
done