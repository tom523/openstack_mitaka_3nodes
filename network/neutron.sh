yum install python-openstackclient openstack-selinux -y

yum install chrony -y
cp conf/chrony.conf /etc/chrony.conf

echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.rp_filter=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.rp_filter=0" >> /etc/sysctl.conf
sysctl -p

yum install openstack-neutron openstack-neutron-ml2 openstack-neutron-openvswitch -y
cp conf/neutron.conf /etc/neutron/neutron.conf
###############
# change here #
###############
cp conf/openvswitch_agent.ini /etc/neutron/plugins/ml2/openvswitch_agent.ini
cp conf/l3_agent.ini /etc/neutron/l3_agent.ini
cp conf/dhcp_agent.ini /etc/neutron/dhcp_agent.ini
cp conf/metadata_agent.ini /etc/neutron/metadata_agent.ini

systemctl start neutron-openvswitch-agent.service neutron-l3-agent.service \
neutron-dhcp-agent.service neutron-metadata-agent.service
systemctl enable neutron-openvswitch-agent.service neutron-l3-agent.service \
neutron-dhcp-agent.service neutron-metadata-agent.service

sed -i "s/ONBOOT=yes/ONBOOT=no/" /etc/sysconfig/network-scripts/ifcfg-eno2

###############
# change here #
###############
cp conf/ifcfg-br-ex /etc/sysconfig/network-scripts/ifcfg-br-ex

ovs-vsctl add-br br-ex
ovs-vsctl add-port br-ex eno2
systemctl restart network.service
