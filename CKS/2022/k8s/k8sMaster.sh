#!/bin/bash
echo "This script is written to work with Ubuntu 18.04"
sleep 3
echo
echo "Disable swap until next reboot"
echo 
sudo swapoff -a

echo "Update the local node"
sudo apt-get update && sudo apt-get upgrade -y
echo
echo "Install Docker"
sleep 3

sudo mkdir /etc/docker
echo "{ \"exec-opts\": [\"native.cgroupdriver=systemd\"]}" | sudo tee /etc/docker/daemon.json

sudo apt-get install -y docker.io
echo
echo "Install kubeadm, kubelet, and kubectl"
sleep 3

sudo sh -c "echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' >> /etc/apt/sources.list.d/kubernetes.list"

sudo sh -c "curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -"

sudo apt-get update

sudo apt-get install -y kubeadm=1.23.1-00 kubelet=1.23.1-00 kubectl=1.23.1-00

sudo apt-mark hold kubelet kubeadm kubectl

echo
echo "Installed - now to get Calico Project network plugin"

## If you are going to use a different plugin you'll want
## to use a different IP address, found in that plugins 
## readme file. 

sleep 3

sudo kubeadm init --kubernetes-version 1.23.1 --pod-network-cidr 192.168.0.0/16

sleep 5

echo "Running the steps explained at the end of the init output for you"

mkdir -p $HOME/.kube

sleep 2

sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

sleep 2

sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "Apply Calico network plugin from ProjectCalico.org"
echo "If you see an error they may have updated the yaml file"
echo "Use a browser, navigate to the site and find the updated file"

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

echo
echo
sleep 3
echo "You should see this node in the output below"
echo "It can take up to a minute for node to show Ready status"
echo
kubectl get node
echo

echo
echo "Script finished. Move to the next step"
