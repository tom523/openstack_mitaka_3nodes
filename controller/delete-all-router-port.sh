> ./all_router_id.txt
source ./admin-openrc
openstack router list  | awk -F'|' '/ [-0-9a-z]{36} / {print $2}' >> ./all_router_id.txt
for id in `cat ./all_router_id.txt`
do
	neutron router-gateway-clear $id
	subnet_id=`neutron router-port-list $id | awk -F'|' '/subnet_id/ {print $5}' | awk -F'"' '{print $4}'`
	neutron  router-interface-delete $id $subnet_id
	openstack router delete $id
done
