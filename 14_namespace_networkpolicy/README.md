## NAMESPACES

* minikube start --network-plugin=cni --extra-config=kubelet.network-plugin=cni

# Namespaces are a way to group resources.

Create two namespaces:
* kubectl create namespace fish
* kubectl create namespace pig

Create some pod inside namespaces:
* kubectl run poddoz -n fish -l app=poddoz --image=nicobenaz/k8s-demo/poddoz:3
* kubectl run poddoz -n pig  -l app=poddoz --image=nicobenaz/k8s-demo/poddoz:3
* kubectl get pod --all-namespaces -o wide
* kubectl get deployment --all-namespaces -o wide

Note that you can have the same of the Deployment resource "poddoz", because it's created in different namespaces.

Create the service for poddoz Deployment (in fish namespace):
* kubectl expose deployment poddoz --namespace fish --type=ClusterIP --port=8080 --name=svc-poddoz
* kubectl get svc -o wide -n fish

Let's see what endpoints are under control of this service:
* kubectl describe svc -n fish svc-poddoz


# PING vs CURL

Let's add another pod with the same selector:
* kubectl run poddoz2 -n fish -l app=poddoz --image=nicobenaz/k8s-demo/poddoz:3
* kubectl describe svc -n fish svc-poddoz
* kubectl exec -ti -n fish <poddoz-name> -- bash
* curl svc-poddoz:8080
* ping svc-poddoz

Curl-ing the service works, but pinging it doesn’t. That’s because the service’s
cluster IP is a virtual IP, and only has meaning when combined with the service port.


# VISIBILITY AMONG NAMESPACES

Let's enter inside the pod in pig namespace:
* kubectl exec -ti -n pig <poddoz-name> -- bash
* curl svc-poddoz.fish:8080

We see that we can call a service in another namespace.
Isolation of pods in one namespace, using labels, does not prevent these pods from being accessed by pods in another namespace.


# ISOLATION OF NAMESPACES WITH NETWORK POLICY

A network policy is a specification of how groups of pods are allowed to communicate with each other and other network endpoints.
Network policies are implemented by the network plugin, so you must be using a networking solution which supports NetworkPolicy - simply creating the resource without a controller to implement it will have no effect.

* kubectl create -f np-fish.yml
* kubectl create -f np-pig.yml
