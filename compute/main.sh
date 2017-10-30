#ntp
yum install chrony -y
cp -f conf/chrony.conf /etc/chrony.conf
systemctl enable chronyd.service
systemctl start chronyd.service
chronyc sources

#openstack client
yum install python-openstackclient openstack-selinux -y

#compute
yum install openstack-nova-compute -y

#neutron
#yum install openstack-neutron-linuxbridge ebtables ipset -y
#cp -f conf/neutron.conf /etc/neutron/neutron.conf

###############
# change here #
###############
#cp -f conf/linuxbridge_agent.ini /etc/neutron/plugins/ml2/linuxbridge_agent.ini

#compute
###############
# change here #
###############
cp -f conf/nova.conf /etc/nova/nova.conf
systemctl enable libvirtd.service openstack-nova-compute.service
systemctl start libvirtd.service openstack-nova-compute.service

#neutron
#systemctl enable neutron-linuxbridge-agent.service
#systemctl start neutron-linuxbridge-agent.service
