## DEPLOYMENTS
Deployments manage the release of new versions (rollout).
They have a strategy section inside their definition (RollingUpdate, Recreate).

Create directly deployment resource, which is going to manage its pod:
* kubectl run poddoz --image=nicobenaz/k8s-demo/poddoz:3
* kubectl get deployment

Now scale the pods:
* kubectl scale deployment poddoz --replicas=4
* kubectl describe deployment poddoz

Note the OldReplicaSets and NewReplicaSets sections, showing that Deployment Resource manages underlying replicasets.

A best practice is to manage new versions with Deployment Resource. It allows you to revert to previous versions in case of errors.


# Rollout a new version

* kubectl create --save-config -f rolling-update.yml
* Change version to 2 in the yml
* kubectl apply -f rolling-update.yml
* kubectl rollout status deployments poddoz
* kubectl get rs -o wide

You can pause and resume a rollout:
* kubectl rollout pause deployment poddoz
* kubectl rollout resume deployment poddoz

If inside the Deployment Manifest the annotation kubernetes.io/change-cause is defined, you can see the change-cause command:
* kubectl rollout history deployment poddoz
* kubectl rollout history deployment poddoz --revision=3

You can undo the rollout:
* kubectl rollout undo deployment poddoz
* kubectl rollout undo deployment poddoz --to-revision=4
