### 1) build poddoz image
docker build -t poddoz:1 .

### 2) run docker
docker run --rm -ePORT=1234 -p 8080:1234 poddoz:1

### 3) call REST service and receive different responses
* curl 127.0.0.1:8080/
* curl 127.0.0.1:8080/cheese
* curl 127.0.0.1:8080/wine
* curl 127.0.0.1:8080/healthy
* curl 127.0.0.1:8080/ready
* curl 127.0.0.1:8080/env
* curl 127.0.0.1:8080/end


### On docker hub there's an image called nicobenaz/k8s-demo/poddoz:5
