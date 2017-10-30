mysql -uroot -p000000 < sql/glance.sql

source ./admin-openrc
openstack user create --domain default --password 000000 glance
openstack role add --project service --user glance admin

openstack service create --name glance \
  --description "OpenStack Image" image
openstack endpoint create --region RegionOne \
  image public http://controller:9292
openstack endpoint create --region RegionOne \
  image internal http://controller:9292
openstack endpoint create --region RegionOne \
  image admin http://controller:9292

yum -y install openstack-glance
cp -f conf/glance-api.conf /etc/glance/glance-api.conf
cp -f conf/glance-registry.conf /etc/glance/glance-registry.conf
su -s /bin/sh -c "glance-manage db_sync" glance

systemctl enable openstack-glance-api.service \
  openstack-glance-registry.service
systemctl start openstack-glance-api.service \
  openstack-glance-registry.service

#verify operation
openstack image create "cirros" \
  --file img/cirros-0.3.4-x86_64-disk.img \
  --disk-format qcow2 --container-format bare \
  --public

openstack image list
