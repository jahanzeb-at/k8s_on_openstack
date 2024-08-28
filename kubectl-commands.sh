# kubectl setup
sudo cp /etc/kubernetes/admin.conf .kube/config
# kubectl get nodes
kubectl get nodes
kubectl get pods -n kube-system

# Doing a test deployment
kubectl create deployment nginx --image=nginx
kubectl get pods -l app=nginx

