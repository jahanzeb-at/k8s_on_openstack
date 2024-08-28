# Getting Kubespray
mkdir ~/Projects/workspace
cd ~/Projects/workspace
git clone https://github.com/kubernetes-sigs/kubespray.git

# Install python
sudo apt install python3

# Install ansible
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible

# Installl python modules
cd ~/Projects/workspace/kubespray
sudo pip3 install -r requirements.txt

# Setting up the Ansible inventory
# Copy `the sample inventory`
cd ~/Projects/workspace/kubespray
cp -rfp inventory/sample inventory/mycluster

# Update Ansible inventory file with inventory builder
declare -a IPS=(192.0.2.11 192.0.2.12 192.0.2.13 192.0.2.14 192.0.2.15 192.0.2.16)
CONFIG_FILE=inventory/mycluster/hosts.yaml \
python3 contrib/inventory_builder/inventory.py ${IPS[@]}

# Verifying SSH connectivity with the nodes
ansible -m ping -i inventory/mycluster/hosts.yaml -u ubuntu all

# Source OpenStack credentials
source k8s-project-openrc.sh

# Deploying the K8S cluster
ansible-playbook -i inventory/mycluster/hosts.yaml \
	-u ubuntu --become cluster.yml

# Tearing down the cluster (if required)
ansible-playbook -i inventory/mycluster/hosts.yaml \
	-u ubuntu --become reset.yml
