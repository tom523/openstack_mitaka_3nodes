#db
mysql -uroot -p000000 < sql/keystone.sql

yum -y install openstack-keystone httpd mod_wsgi
#conf
cp -f conf/keystone.conf /etc/keystone/keystone.conf
cp -f conf/httpd.conf /etc/httpd/conf/httpd.conf
cp -f conf/wsgi-keystone.conf /etc/httpd/conf.d/wsgi-keystone.conf

# Populate the Identity service database
su -s /bin/sh -c "keystone-manage db_sync" keystone
keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone

systemctl enable httpd.service
systemctl start httpd.service

export OS_TOKEN=921ad883e4208185d762
export OS_URL=http://controller:35357/v3
export OS_IDENTITY_API_VERSION=3
openstack service create --name keystone --description "OpenStack Identity" identity
openstack endpoint create --region RegionOne identity public http://controller:5000/v3
openstack endpoint create --region RegionOne \
  identity internal http://controller:5000/v3
openstack endpoint create --region RegionOne \
  identity admin http://controller:35357/v3

#create a domain projects users and roles
openstack domain create --description "Default Domain" default
openstack project create --domain default \
  --description "Admin Project" admin
openstack user create --domain default \
  --password 000000 admin
openstack role create admin
openstack role add --project admin --user admin admin

openstack project create --domain default \
  --description "Service Project" service
openstack project create --domain default \
  --description "Demo Project" demo

openstack user create --domain default \
  --password 000000 demo
openstack role create user
openstack role add --project demo --user demo user
