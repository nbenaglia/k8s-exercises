# Cluster Certificate Auhtority

Reference: https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/

Every Kubernetes cluster has a cluster root Certificate Authority (CA).
The CA is generally used by cluster components to validate the API server’s certificate, by the API server to validate kubelet client certificates, etc.


## SELF-SIGNED CERTIFICATE GENERATION

Generate private key with passphase
* openssl genrsa -aes128 -out private.key 2048

Remove encryption key
* openssl rsa -in private.key -out nicobenaz.key

Generate certificate signing request (CSR) with no encrypted key, insert your certificate information
* openssl req -new -key nicobenaz.key -out nicobenaz.csr

Sign CSR with your key
* openssl x509 -req -days 3650 -in nicobenaz.csr -signkey nicobenaz.key -out nicobenaz.crt

Create a text file with certificate information
* openssl x509 -noout -fingerprint -text < nicobenaz.crt > nicobenaz.info

You should have these files:

- private.key: your private aes128 encrypted key
- nicobenaz.crt: your self-signed certificate
- nicobenaz.csr: your certificate signing request
- nicobenaz.info: readable information about your certificate
- nicobenaz.key: non-encrypted private key



## SUBMIT CSR TO KUBERNETES

Send certificate to K8S for approval
* cat <<EOF | kubectl create -f 
```
apiVersion: certificates.k8s.io/v1beta1
kind: CertificateSigningRequest
metadata:
  name: nicobenaz_k8s_ca
spec:
  groups:
  - system:authenticated
  request: $(cat nicobenaz.csr | base64 | tr -d '\n')
  usages:
  - digital signature
  - key encipherment
  - server auth
EOF
```
Check your CSR status
* kubectl get csr

NAME                  AGE       REQUESTOR       CONDITION
nicobenaz_k8s_ca         4s        minikube-user   Pending

A Kubernetes administrator (with appropriate permissions) can manually approve (or deny) CSRs:
* kubectl certificate approve nicobenaz_k8s_ca

Check new status
* kubectl get csr
```
NAME                  AGE       REQUESTOR       CONDITION
nicobenaz_k8s_ca         4s        minikube-user   Approved,Issued
```
Check info about your certificate
* kubectl describe csr nicobenaz_k8s_ca
```
Name:               nicobenaz_k8s_ca
Labels:             <none>
Annotations:        <none>
CreationTimestamp:  Sat, 23 Jun 2018 10:31:15 +0200
Requesting User:    minikube-user
Status:             Approved,Issued
Subject:
         Common Name:    nicola
         Serial Number:  
         Organization:   SorintLab S.p.A.
         Country:        IT
         Locality:       Bergamo
         Province:       Lombardia
Events:  <none>
```
You can download the issued certificate and save it to a server.crt file
* kubectl get csr nicobenaz_k8s_ca -o jsonpath='{.status.certificate}' | base64 -d > server.crt

Generate PEM from CRT
* openssl x509 -inform DER -outform PEM -in server.crt -out server.pem

Now you can use server.crt and server-key.pem as the keypair to start your HTTPS server
