for user in `cat ./$1`
do
	source ./admin-openrc
	openstack project create --domain default \
	  --parent student $user
	openstack user create --domain default \
	  --password 000000 $user
	openstack role add --project $user --user $user user
	openstack quota set --instances 2 --cores 2 $user
done
