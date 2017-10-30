if [ ! -n "$1" ] ;then  
    echo "you have not input a word!"  
    exit
else  
    echo "the word you input is $1"  
fi 
echo "start deleting floating ip"
> ./all_floating_ip_id.txt
source ./admin-openrc
openstack ip floating list  | awk -F'|' '/ [-0-9a-z]{36} / {print $2}' >> ./all_floating_ip_id.txt
for id in `cat ./all_floating_ip_id.txt`
do
        openstack ip floating delete $id
	echo "delete ip " + $id
done

echo "start clearing router-gateway"
> ./all_router_id.txt
source ./admin-openrc
openstack router list  | awk -F'|' '/ [-0-9a-z]{36} / {print $2}' >> ./all_router_id.txt
for id in `cat ./all_router_id.txt`
do
	#neutron router-port-list $id
	neutron router-gateway-clear $id
	#subnet_id=`neutron router-port-list $id | awk -F'|' '/subnet_id/ {print $5}' | awk -F'"' '{print $4}'`
	#neutron  router-interface-delete $id $subnet_id
	#openstack router delete $id
done

echo "start stoping server"
> ./all_server_id.txt
for user in `cat $1`
do
	source ./admin-openrc
	openstack server list --project $user
	openstack server list --project $user  | awk -F'|' '/ [-0-9a-z]{36} / {print $2}' >> ./all_server_id.txt
done
for server_id in `cat ./all_server_id.txt`
do
	openstack server stop $server_id
	#openstack server delete $server_id
	echo "stop server "  $server_id
done
