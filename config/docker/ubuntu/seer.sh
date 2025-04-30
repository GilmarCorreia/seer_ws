# Configure language
export LANG=pt_BR.UTF-8

# Show git branch name
force_color_prompt=yes
color_prompt=yes
parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
if [ "$color_prompt" = yes ]; then
 PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\$ '
else
 PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\$ '
fi
unset color_prompt force_color_prompt

# ROS Humble Setup
source /opt/ros/humble/setup.bash

# ROS Humble SEER Workspace
source $SEER_WS_DIR/install/setup.bash

# Setting GAZEBO
source /usr/share/gazebo/setup.sh
export LIBGL_ALWAYS_SOFTWARE=1
export GAZEBO_MODEL_PATH=~/.gazebo/models:$SEER_WS_DIR/install/senai_models/share
export GAZEBO_PLUGIN_PATH=$SEER_WS_DIR/install/gazebo_logger/lib:$GAZEBO_PLUGIN_PATH

# Setting COPPELIASIM
coppeliasim_version="V4_7_0_rev4"
export COPPELIASIM_ROOT_DIR=$SEER_DIR/Downloads/CoppeliaSim_Edu_${coppeliasim_version}_Ubuntu22_04