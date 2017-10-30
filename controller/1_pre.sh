#hosts
#cp -f conf/hosts /etc/hosts

yum install chrony -y
###############
# change here #
###############
cp -f conf/chrony.conf /etc/chrony.conf
systemctl enable chronyd.service
systemctl start chronyd.service

#openstack-client
yum install python-openstackclient openstack-selinux -y

#mariadb
yum install mariadb mariadb-server python2-PyMySQL -y
###############
# change here #
###############
cp -f conf/openstack.cnf /etc/my.cnf.d/openstack.cnf 
systemctl enable mariadb.service
systemctl start mariadb.service
mysql_secure_installation

#rabbitmq
yum install rabbitmq-server -y
systemctl enable rabbitmq-server.service
systemctl start rabbitmq-server.service
rabbitmqctl add_user openstack 000000
rabbitmqctl set_permissions openstack ".*" ".*" ".*"

#Memcached
yum install memcached python-memcached -y
systemctl enable memcached.service
systemctl start memcached.service

systemctl status memcached.service rabbitmq-server.service mariadb.service chronyd.service
rabbitmqctl list_permissions
