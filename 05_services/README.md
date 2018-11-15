## SERVICES AND INGRESSES

# SERVICES
* kubectl create -f deployment.yml
* kubectl create -f service.yml

Enter inside a pod:
* kubectl exec -ti <pod-name> -- bash
* curl poddoz-svc/healthy
* curl poddoz-svc/wine

Now you're calling a pod from a service.
If you repeat multiple times a single command, a different pod (from previous one) may reply, since service uses a random policy in choosing a pod.

# Add in the hosts file:
minikube ip
will write the cluster master's IP address, for example 192.168.99.100

# linux/mac
echo "$(minikube ip) myminikube.info cheeses.all" | sudo tee -a /etc/hosts

# windows
In file c:\windows\system32\drivers\etc\hosts add
192.168.99.100 myminikube.info cheeses.all


# NODEPORT
* kubectl create -f nodeport.yml
* curl myminikube.info:31999/healthy

Every node has now opened port 31999 from which you can reach the service called nodeport-svc.


# INGRESS
* minikube addons list
* minikube addons enable ingress
* kubectl create -f ingress.yml
* kubectl describe ing poddoz-ing

Now you can query your pods:
* curl myminikube.info
* curl myminikube.info/healthy
* curl cheeses.all/stilton/wine
* curl cheeses.all/cheddar/cheese
* curl cheeses.all/cheddar/ready


# ENDPOINTS
* kubectl get endpoints
* kubectl describe endpoints nodeport-svc


# EXTERNAL IP
If there are external IPs that route to one or more cluster nodes, Kubernetes services can be exposed on those externalIPs.
Traffic that ingresses into the cluster with the external IP (as destination IP), on the service port, will be routed to one of the service endpoints.
ExternalIPs are not managed by Kubernetes and are the responsibility of the cluster administrator.

* kubectl create -f service_IP.yml
* sudo route add -net 172.1.1.0 netmask 255.255.255.0 gw 192.168.99.100
* curl 172.1.1.10
At / Poddoz says its name is poddoz-65f67f6fcd-sfm6n
* curl 192.168.99.100
curl: (7) Failed to connect to 192.168.99.100 port 80: Connection refused
