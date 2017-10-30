> ./all_subnet_id.txt
> ./all_network_id.txt
source ./admin-openrc
openstack subnet list  | awk -F'|' '/ [-0-9a-z]{36} / {print $2}' >> ./all_subnet_id.txt
openstack network list | awk -F'|' '/ [-0-9a-z]{36} / {print $2}' >> ./all_network_id.txt
for id in `cat ./all_subnet_id.txt`
do
	openstack subnet delete $id
done
for id in `cat ./all_network_id.txt`
do
	openstack network delete $id
done
