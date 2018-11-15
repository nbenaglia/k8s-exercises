# Traefik - https://traefik.io/

Træfik is a modern HTTP reverse proxy and load balancer that makes deploying microservices easy. Træfik integrates with your existing infrastructure components (Docker, Swarm mode, Kubernetes, Marathon, Consul, Etcd, Rancher, Amazon ECS, ...) and configures itself automatically and dynamically. Pointing Træfik at your orchestrator should be the only configuration step you need.

# TLS certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=traefik-ui.minikube"

# Secret provision
kubectl -n kube-system create secret tls traefik-ui-tls-cert --key=tls.key --cert=tls.crt


