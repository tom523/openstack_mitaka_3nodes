> ./all_floating_ip_id.txt
source ./admin-openrc
openstack ip floating list  | awk -F'|' '/ [-0-9a-z]{36} / {print $2}' >> ./all_floating_ip_id.txt
for id in `cat ./all_floating_ip_id.txt`
do
        openstack ip floating delete $id
done
