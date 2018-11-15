# VOLUMES

On-disk files in a Container are ephemeral, which presents some problems for non-trivial applications when running in Containers.
First, when a Container crashes, kubelet will restart it, but the files will be lost - the Container starts with a clean state.
Second, when running Containers together in a Pod it is often necessary to share files between those Containers.
The Kubernetes Volume abstraction solves both of these problems.

Run all yml in order (0, 1, 2, ...):
* kubectl create -f <name_of_yml>
