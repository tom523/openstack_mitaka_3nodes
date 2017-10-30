. ./admin-openrc
neutron net-create --shared --provider:physical_network provider \
  --provider:network_type flat provider
neutron subnet-create --name provider \
  --allocation-pool start=192.168.144.20,end=192.168.144.100 \
  --allocation-pool start=192.168.144.115,end=192.168.144.200 \
  --dns-nameserver 8.8.4.4 --gateway 192.168.147.254 \
  provider 192.168.144.0/22
. ./demo-openrc
neutron net-create selfservice
neutron subnet-create --name selfservice \
  --dns-nameserver 8.8.4.4 --gateway 172.16.1.1 \
  selfservice 172.16.1.0/24
. ./admin-openrc
neutron net-update provider --router:external
. ./demo-openrc
neutron router-create router
neutron router-interface-add router selfservice
neutron router-gateway-set router provider

#ssh-keygen -q -N ""
#openstack keypair create --public-key ~/.ssh/id_rsa.pub mykey
