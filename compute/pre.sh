# compute
sed -i 's/MANAGEMENT_INTERFACE_IP_ADDRESS//' nova.conf
#neutron OVERLAY_INTERFACE_IP_ADDRESS=MANAGEMENT_INTERFACE_IP_ADDRESS
sed -i 's/PROVIDER_INTERFACE_NAME//' linuxbridge_agent.ini
sed -i 's/OVERLAY_INTERFACE_IP_ADDRESS//' linuxbridge_agent.ini

