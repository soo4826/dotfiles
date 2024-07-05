################# Custom setup #################

# CUDA
export LD_LIBRARY_PATH=/opt/ros/noetic/lib:/usr/local/cuda/bin:/usr/local/cuda/lib64:/home/ailab/Library/TensorRT-8.5.3.1/lib #:$LD_LIBRARY_PATH
export PATH=/usr/local/cuda/bin:$PATH

# Build shortcut
alias cm='catkin_make'
#alias cmr='catkin_make -DCMAKE_BUILD_TYPE=Release'
alias cmd='catkin_make -DCMAKE_BUILD_TYPE=Debug'
alias cmrp='catkin_make -DCMAKE_BUILD_TYPE=Release -DCATKIN_WHITELIST_PACKAGES='
export CONTROL_PKG="lateral_control\;longitudinal_control\;"
alias cmrr='catkin_make -DCMAKE_BUILD_TYPE=Release -DCATKIN_BLACKLIST_PACKAGES='$CONTROL_PKG''
alias cmr='cmrr'
# Build without lanelet
export LANELET_PKG='lanelet2_matching\;lanelet2\;lanelet2_core\;lanelet2_io\;lanelet2_maps\;lanelet2_projection\;lanelet2_traffic_rules\;lanelet2_routing\;lanelet2_python\;lanelet2_validation\;lanelet2_examples\;global_planning\;object_driver\;state_estimation\;'
alias cml='catkin_make -DCMAKE_BUILD_TYPE=Release -DCATKIN_BLACKLIST_PACKAGES='$LANELET_PKG''

alias rdb='rm -rf build/ devel/'

# Source shortcut
alias sd='source devel/setup.bash'
alias si='source install/setup.bash'
alias sb='source ~/.bashrc'
alias gb='gedit ~/.bashrc'

# Conda shortcut
alias ce='conda env list'
alias ca='conda activate'

# NVIDIA shortcut
alias ns='watch -d -n 0.1 nvidia-smi'
alias gs='gpustat -i'
alias cn='cat /usr/local/cuda/include/cudnn_version.h | grep CUDNN_MAJOR -A 2'
# Docker shortcut
alias dp='docker ps -a'
alias di='docker images'

# Mount NFS
alias ad="sudo mount ailabdataset.synology.me:/volume1/AILabDataset /home/ailab/AILabDataset"

# ROS
source /opt/ros/noetic/setup.bash


# AutoKU
# source /home/ailab/git/autoku/devel/setup.bash
alias akcm='sudo -u $USER ./autoku_cm.sh'
alias ak='sudo -u $USER ./autoku.sh'
alias runku='sudo -u $USER ./autoku_cm.sh'


## Local master
# export ROS_MASTER_URI=http://localhost:11311
# export ROS_HOSTNAME=localhost
## Multi-master
### Example: Decision master(perception is slave)
# export ROS_MASTER_URI=http://192.168.2.102:11311 #(Decision IP)
# export ROS_IP=192.168.2.101 #(Perception IP)
# export ROS_HOSTNAME=192.168.2.101 #(Perception IP)

### Example: Perception master(RSCube is slave)
# WSL2 Failue... (TODO)
# export ROS_MASTER_URI=http://192.168.1.102:11311 #(Perception IP)
# export ROS_IP=192.168.1.102 #(Perception IP)
# export ROS_HOSTNAME=192.168.1.102 #(Perception IP)

# Configure ROS-Master, RMW(ROS2)
alias ros-master='source ~/git/dotfiles/shell/ros-master/ros-master.sh'
alias ros-rmw='source ~/git/dotfiles/shell/ros-rmw/ros-rmw.sh'