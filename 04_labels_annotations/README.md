## LABEL AND ANNOTATIONS

# Labels are key/value pairs.

## Try:
* kubectl run poddoz --image=nicobenaz/k8s-demo/poddoz:3 --labels="version=3,env=test,app=poddoz"
* kubectl run poddoz2 --image=nicobenaz/k8s-demo/poddoz:3 --labels="version=3,env=canary,app=poddoz"
* kubectl run poddoz3 --image=nicobenaz/k8s-demo/poddoz:3 --labels="version=3,env=production,app=poddoz"
* kubectl get po --show-labels

Add other labels:
* kubectl label pod <pod-name> "author=nicola"
* kubectl label pod <other-pod-name> "author=fabio"
* kubectl get po --show-labels
* kubectl get po -L author
* kubectl get po -l author=nicola --show-labels
* kubectl get po --selector="env in (canary, test)" --show-labels

Remove a label:
* kubectl label pod <pod-name> "author-"

# Annotations provide a place to store additional metadata for Kubernetes objects, generally used by tools and libraries.
# While labels are used to identify and group objects, annotations are used to provide extra information about where an object came from, how to use it, or policy around that object.

In general you must use a label if later you need to use a selector.
Annotations may have a namespace inside the key: deployment.kubernetes.io/revision="3.0"

* kubectl annotate pod <pod-name> it.nicobenaz.deployment.status="stable"
* kubectl annotate pod <pod-name> it.nicobenaz.developer.team="dev.arch"
* kubectl annotate pod <pod-name> it.nicobenaz.application.responsible.email="nico.benaz@gmail.com"
* kubectl annotate pod <pod-name> it.nicobenaz.application.responsible.mobile="555-123-456-789"
* kubectl describe pod <pod-name> | grep -i annotations
* kubectl annotate pod <pod-name> it.nicobenaz.deployment.status-
