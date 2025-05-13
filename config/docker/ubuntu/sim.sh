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

# ROS Humble Sim Workspace
source $SIM_WS_DIR/install/setup.bash

# Setting GAZEBO
source /usr/share/gazebo/setup.sh
export LIBGL_ALWAYS_SOFTWARE=1
export GAZEBO_MODEL_PATH=~/.gazebo/models:$SIM_WS_DIR/install/sim_models/share

# Setting COPPELIASIM
coppeliasim_version="V4_9_0_rev6"
export COPPELIASIM_ROOT_DIR=$SIM_DIR/Downloads/CoppeliaSim_Edu_${coppeliasim_version}_Ubuntu22_04