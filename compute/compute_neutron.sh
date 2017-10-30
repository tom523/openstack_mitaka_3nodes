echo "net.ipv4.conf.all.rp_filter=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.rp_filter=0" >> /etc/sysctl.conf
sysctl -p

yum install openstack-neutron openstack-neutron-ml2 openstack-neutron-openvswitch -y
cp -f conf/neutron.conf /etc/neutron/neutron.conf
###############
# change here #
###############
cp -f conf/openvswitch_agent.ini /etc/neutron/plugins/ml2/openvswitch_agent.ini

systemctl enable neutron-openvswitch-agent.service
systemctl start neutron-openvswitch-agent.service
