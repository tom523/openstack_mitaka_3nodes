sed -i 's/PROVIDER_INTERFACE_NAME/enp4s0/g' conf/linuxbridge_agent.ini
sed -i 's/CONTROLLER_MANAGEMENT_IP/192.168.100.11/g' conf/linuxbridge_agent.ini conf/nova.conf
sed -i 's/^allow/192.168.100.0\/24/g' conf/chrony.conf
