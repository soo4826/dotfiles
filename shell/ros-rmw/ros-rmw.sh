#!/bin/bash

# Mapping of short names to full RMW implementation names
declare -A RMW_MAP
RMW_MAP=(
    ["fast"]="rmw_fastrtps_cpp"
    ["cyclone"]="rmw_cyclonedds_cpp"
    ["connext"]="rmw_connextdds"
    ["opensplice"]="rmw_opensplice_cpp"
    ["goorm"]="rmw_goorm"
)

# Function to display usage information
usage() {
    echo "Usage: $0 {fast|cyclone|connext|opensplice|goorm}"
    exit 1
}

# Function for tab completion setup
_complete_rmw() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "fast cyclone connext opensplice goorm" -- $cur) )
}
complete -F _complete_rmw switch_rmw.sh

# Check if no arguments are provided
if [ -z "$1" ]; then
    usage
fi

# Check if the provided argument is a supported short name
if [[ ! ${RMW_MAP[$1]+_} ]]; then
    echo "Error: Unsupported RMW implementation: $1"
    usage
fi

# Convert short name to full name
RMW_IMPLEMENTATION=${RMW_MAP[$1]}

# Set the color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Get the current RMW implementation
current_rmw=$(echo $RMW_IMPLEMENTATION)

# Display the current RMW implementation in red
echo -e "Current RMW implementation: ${RED}$current_rmw${NC}"

# Set the RMW_IMPLEMENTATION environment variable
export RMW_IMPLEMENTATION=$RMW_IMPLEMENTATION
echo "Switched to RMW implementation: $RMW_IMPLEMENTATION"

# Re-source the ROS 2 environment
source /opt/ros/foxy/setup.bash
echo "ROS 2 environment re-sourced"

# Display the new RMW implementation in green
echo -e "New RMW implementation: ${GREEN}$RMW_IMPLEMENTATION${NC}"
