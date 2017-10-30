> ./all_subnet_id.txt
source ./admin-openrc
openstack subnet list  | awk -F'|' '/ [-0-9a-z]{36} / {print $2}' >> ./all_subnet_id.txt
