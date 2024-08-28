# Kubernetes on OpenStack
The repository contains shell commands to deploy K8s cluster on OpenStack using Kubespray.

- openstack-commands.sh: Commands to setup networking, create security groups and provision instances for kubernetes nodes.
- kubespray-setup.sh: Commands to get kubespray, install required python modules and ansible, setup the ansible repository. Deploy K8s using kubespray and tear down the cluster if required.
- kubectl-commands.sh: Kubectl setup and test a deployment
