yum install openstack-dashboard -y
cp -f conf/local_settings /etc/openstack-dashboard/local_settings
systemctl restart httpd.service memcached.service
