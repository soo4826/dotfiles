#!/bin/bash
# This script helps configure ROS_MASTER_URI, ROS_IP, and ROS_HOSTNAME.

# Function to get available IP addresses excluding localhost
get_ip() {
    ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
}

# Function to initialize ROS settings to localhost
initialize() {
    export ROS_MASTER_URI="http://localhost:11311"
    export ROS_IP="127.0.0.1"
    export ROS_HOSTNAME="localhost"
}

# Function to set this machine as ROS Master
set_master() {
    local iface_ip=$1
    export ROS_MASTER_URI="http://${iface_ip}:11311"
    export ROS_IP="${iface_ip}"
    export ROS_HOSTNAME="${iface_ip}"
}

# Function to set another machine as ROS Master
set_other_master() {
    local other_ip=$1
    local iface_ip=$2
    export ROS_MASTER_URI="http://${other_ip}:11311"
    export ROS_IP="${iface_ip}"
    export ROS_HOSTNAME="${iface_ip}"
}

# Function to select IP address
select_ip() {
    IP_LIST=($1)
    PS3=$'\e[95mSelect a network interface: \e[0m'
    select IP in "${IP_LIST[@]}"; do
        if [[ -n $IP ]]; then
            echo $IP
            break
        else
            echo -e "\e[91mInvalid selection. Please try again.\e[0m"
        fi
    done
}

# Function to print help
print_help() {
    echo -e "\e[93mUSAGE: source ros-master.sh\e[0m"
    echo -e "\e[92mOptions:\e[0m"
    echo -e "\e[94m  1:\e[0m Localhost mode"
    echo -e "\e[94m  2:\e[0m Set this machine as ROS Master"
    echo -e "\e[94m  3:\e[0m Set another machine as ROS Master"
    echo -e "\e[94m  -h:\e[0m Print help"
}

# Check if help is requested
if [[ $1 == "-h" ]]; then
    print_help
    return 0
fi

# Ask user to select configuration mode
echo -e "\e[93mSelect configuration mode:\e[0m"
echo -e "\e[94m  1:\e[0m Localhost mode"
echo -e "\e[94m  2:\e[0m Set this machine as ROS Master"
echo -e "\e[94m  3:\e[0m Set another machine as ROS Master"
read -p $'\e[93mSelection: \e[0m' mode

case $mode in
    1)
        initialize
        echo -e "\e[92mROS Master URI and IP reset to localhost.\e[0m"
        ;;
    2)
        IP_LIST=$(get_ip)
        IP_ARRAY=($IP_LIST)

        if [ ${#IP_ARRAY[@]} -eq 0 ]; then
            echo -e "\e[91mNo connection. Falling back to localhost.\e[0m"
            initialize
        else
            echo -e "\e[93mAvailable network interfaces:\e[0m"
            IFACE_IP=$(select_ip "${IP_ARRAY[@]}")
            set_master "$IFACE_IP"
            echo -e "\e[92mThis machine is set as ROS Master with IP: $IFACE_IP\e[0m"
        fi
        ;;
    3)
        IP_LIST=$(get_ip)
        IP_ARRAY=($IP_LIST)

        if [ ${#IP_ARRAY[@]} -eq 0 ]; then
            echo -e "\e[91mNo connection. Falling back to localhost.\e[0m"
            initialize
        else
            echo -e "\e[93mAvailable network interfaces:\e[0m"
            IFACE_IP=$(select_ip "${IP_ARRAY[@]}")
            read -p $'\e[93mEnter the Master IP: \e[0m' MASTER_IP
            set_other_master "$MASTER_IP" "$IFACE_IP"
            echo -e "\e[92mROS Master URI is set to $MASTER_IP, and this machine's IP is set to $IFACE_IP\e[0m"
        fi
        ;;
    *)
        echo -e "\e[91mInvalid selection.\e[0m"
        print_help
        ;;
esac

# Print the settings
echo -e "\e[93mROS_MASTER_URI: \e[96m$ROS_MASTER_URI \e[0m"
echo -e "\e[93mROS_HOSTNAME: \e[96m$ROS_HOSTNAME \e[0m"
echo -e "\e[93mROS_IP: \e[96m$ROS_IP \e[0m"
