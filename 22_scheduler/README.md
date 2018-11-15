# Scheduler

Reference: https://kubernetes.io/docs/reference/command-line-tools-reference/kube-scheduler/

The scheduler goes through a set of filters, or predicates, to find available nodes, then ranks each node using priority functions.
In a specific json file you can configure a new scheduler with custom predicates and priorities.

* kube-scheduler --policy-config-file scheduler-policy.json --scheduler-name my-second-scheduler


With multiple schedulers, there could be conflict in the Pod allocation. Each Pod should declare which scheduler should be used.
Most scheduling decisions can be made as part of the Pod specification. A pod specification contains several fields that inform scheduling, namely:
    - nodeName
    - nodeSelector
    - affinity
    - schedulerName
    - tolerations

    
