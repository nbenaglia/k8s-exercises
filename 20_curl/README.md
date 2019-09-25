# CURL AND K8S

You can instruct K8S master with CURL, instead of using KUBECTL. 

Under the hood KUBECTL uses CURL.

Try a kubectl command adding the param --v=9 and see logs.

You'll notice the CURL command executed.

To manually use CURL, you need to use the correct credentials to connect to K8S master.

* see credentials information inside your kube config file:

`less ~/.kube/config`

* export client

`export client=$(grep client-cert ~/.kube/config |cut -d" " -f 6)`

* export key

`export key=$(grep client-key-data ~/.kube/config |cut -d " " -f 6)`

* export auth

`export auth=$(grep certificate-authority-data ~/.kube/config |cut -d " " -f 6)`

* create certificate files

`echo $client | base64 -d - > ./client.pem`
`echo $key | base64 -d - > ./client-key.pem`
`echo $auth | base64 -d - > ./ca.pem`

* take the master IP (https)

`kubectl config view |grep server`

* query the api pods

`curl --cert ./client.pem --key ./client-key.pem --cacert ./ca.pem https://10.128.0.3:6443/api/v1/pods`

* deploy a new pod

`curl --cert ./client.pem --key ./client-key.pem --cacert ./ca.pem https://10.128.0.3:6443/api/v1/namespaces/default/pods -XPOST -H’Content-Type: application/json’ -d@example_pod.json`
