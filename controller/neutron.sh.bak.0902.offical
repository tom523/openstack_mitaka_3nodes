mysql -u root -p000000 < sql/neutron.sql

source ./admin-openrc
openstack user create --domain default --password 000000 neutron
openstack role add --project service --user neutron admin
openstack service create --name neutron \
  --description "OpenStack Networking" network
openstack endpoint create --region RegionOne \
  network public http://controller:9696
openstack endpoint create --region RegionOne \
  network internal http://controller:9696
openstack endpoint create --region RegionOne \
  network admin http://controller:9696

#option2 Self-service networks
yum install openstack-neutron openstack-neutron-ml2 \
  openstack-neutron-linuxbridge ebtables -y
cp -f conf/neutron.conf /etc/neutron/neutron.conf
cp -f conf/ml2_conf.ini /etc/neutron/plugins/ml2/ml2_conf.ini
###############
# change here #
###############
cp -f conf/linuxbridge_agent.ini /etc/neutron/plugins/ml2/linuxbridge_agent.ini
cp -f conf/l3_agent.ini /etc/neutron/l3_agent.ini
cp -f conf/dhcp_agent.ini /etc/neutron/dhcp_agent.ini
cp -f conf/metadata_agent.ini /etc/neutron/metadata_agent.ini

# start nova service

systemctl enable openstack-nova-api.service \
  openstack-nova-consoleauth.service openstack-nova-scheduler.service \
  openstack-nova-conductor.service openstack-nova-novncproxy.service
systemctl start openstack-nova-api.service \
  openstack-nova-consoleauth.service openstack-nova-scheduler.service \
  openstack-nova-conductor.service openstack-nova-novncproxy.service

ln -s /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugin.ini
su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf \
  --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head" neutron

# start neutron service
systemctl enable neutron-server.service \
  neutron-linuxbridge-agent.service neutron-dhcp-agent.service \
  neutron-metadata-agent.service
systemctl start neutron-server.service \
  neutron-linuxbridge-agent.service neutron-dhcp-agent.service \
  neutron-metadata-agent.service
systemctl start neutron-l3-agent.service
