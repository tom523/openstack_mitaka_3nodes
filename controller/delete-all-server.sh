> ./all_server_id.txt
for user in `cat ./$1`
do
        source ./admin-openrc
        openstack server list --project $user  | awk -F'|' '/ [-0-9a-z]{36} / {print $2}' >> ./all_server_id.txt
done
for server_id in `cat ./all_server_id.txt`
do
        #openstack server stop $server_id
        openstack server delete $server_id
        echo "delete server "  $server_id
done
