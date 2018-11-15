## System resource inspection (namespace kube-system)

Some commmands are very useful to inspect resources and print their yaml manifest.

### 1) daemonset
* kubectl get daemonsets --namespace=kube-system

###### Describe resource
* kubectl describe daemonsets --namespace=kube-system kube-proxy

###### Export yaml
* kubectl get daemonsets --namespace=kube-system -o yaml kube-proxy

### 2) deployments
* kubectl get deployments --namespace=kube-system

### 3) services
* kubectl get services --namespace=kube-system


## Debugging commands
* kubectl help
* kubectl help <command-name>
* kubectl logs <pod-name>
* kubectl exec -it <pod-name> -- bash
* kubectl cp <pod-name>:/path/to/remote-file /path/to/local-file


## Minikube's docker
To see minikube's docker you need to swith to its environment.

* eval $(minikube docker-env)
* docker ps -a
