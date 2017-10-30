for user in `cat ./$1`
do
	source ./admin-openrc
	openstack user delete $user
	openstack project delete $user
done
