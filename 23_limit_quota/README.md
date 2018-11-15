# LIMIT RANGE

LimitRange sets resource usage limits for each kind of resource in a Namespace.



# RESOURCE QUOTAS

LimitRanges only apply to individual pods, but cluster admins also need a way to limit the total amount of resources available in a namespace. 
This is achieved by creating a ResourceQuota object.

* kubectl create -f resourceQuota.yml -n quota-mem-cpu-example

See consumption status:
* kubectl get resourcequota mem-cpu-demo --namespace=quota-mem-cpu-example --output=yaml
