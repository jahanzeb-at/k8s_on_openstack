# Source the OpenStack credentials
source k8s-project-openrc.sh

# Setting up networking and security groups
openstack security group create k8s-cluster
openstack security group rule create --ingress \
	--remote-ip 192.0.2.0/24 --protocol tcp k8s-cluster
openstack security group rule create --ingress \
	--remote-ip 192.0.2.0/24 --protocol udp k8s-cluster
openstack security group rule create --ingress \
	--remote-ip 192.0.2.0/24 --protocol icmp k8s-cluster
openstack security group rule create --ingress \
	--remote-ip 0.0.0.0/0 --protocol tcp --dst-port 22 k8s-cluster
openstack security group rule create --ingress \
	--remote-ip 0.0.0.0/0 --protocol tcp --dst-port 443 k8s-cluster
openstack security group rule create --ingress \
	--remote-ip 0.0.0.0/0 --protocol tcp --dst-port 6443 k8s-cluster

# Provisioning compute instances for Kubernetes node
for i in $(seq 1 6); do
  INSTANCE_NAME="node-${i}"
  openstack server create --flavor sm3.small --network k8snet \
                          --image ubuntu-22.04-amd64.img  \
                          --key-name SSH-KEY \
                          --security-group k8s-cluster \
                          $INSTANCE_NAME
done

