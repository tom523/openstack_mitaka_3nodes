for user in user{01..55}
do
	source ./admin-openrc
	#openstack project create --domain default $user
	#openstack user create --domain default \
	  #--password 000000 $user
	#openstack role add --project $user --user $user user
	#openstack quota set --instances 2 --cores 2 $user
        openstack user delete $user
        openstack project delete $user
done
