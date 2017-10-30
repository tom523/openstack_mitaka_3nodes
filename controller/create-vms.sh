for vm in vm{1..45}
do
 openstack server create --flavor m1.small --image centos7 \
  --nic net-id=38c82ee1-a5d5-485f-a4ca-6e3c0e3b4bfb --security-group default \
  --key-name mykey $vm
done
