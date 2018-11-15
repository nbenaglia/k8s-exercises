## WARMUP WITH POD RESOURCE

You can create a pod in two ways:

##### from command line interface
* kubectl run poddoz --image=nicobenaz/k8s-demo/poddoz:3

##### from YML file
* kubectl create -f poddoz.yml

## Try:
* kubectl get po
* kubectl logs poddoz
* kubectl describe pod poddoz
* kubectl delete pods/poddoz
* kubectl delete deployments/poddoz

## REST calls
### 1) Open a port forward to a running poddoz
* kubectl port-forward poddoz 8080:8080

This command opened a direct connection from your laptop to poddoz inside the cluster.
You can open another terminal and execute REST call with curl (see point 3).

### 2) Connect to pod
* kubectl exec -ti poddoz -- bash

This command let you enter inside the running container.

### 3) You can execute the following instructions:
* curl 127.0.0.1:8080/
* curl 127.0.0.1:8080/healthy
* curl 127.0.0.1:8080/ready
* curl 127.0.0.1:8080/cheese
* curl 127.0.0.1:8080/wine
* curl 127.0.0.1:8080/env
* kubectl logs poddoz


## COPY FILE TO POD
* kubectl cp superfile.txt poddoz:/superfile.txt
* kubectl exec -ti poddoz -- cat superfile.txt

Now delete your pod, recreate it and execute again the cat command.
Where is superfile.txt?


## CONTAINERS IN A POD SHARE VOLUMES
Analyze sharing.yml file and launch it
