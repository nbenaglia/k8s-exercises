## REPLICASETS

# Create a replica resource:
* kubectl create -f replicaset.yml
* kubectl get rs
* kubectl describe rs poddoz-rs
* kubectl describe po <pod-name>

Looking at the output, you can notice the line:
  Controlled By:  ReplicaSet/poddoz-rs

Replicaset manages all pods with label app=poddoz
Now remove the controlling label from a pod:
* kubectl label po <pod-name> app-

A new pod will be created by replicaset, because actual pod number (with app=poddoz label) is less than desired (reconciliation loop).
* kubectl get po

Scale the number of replicas:
* kubectl scale replicaset poddoz-rs --replicas 7
