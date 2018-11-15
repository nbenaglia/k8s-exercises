**********
   USER
**********

* Create private key for user
openssl genrsa -out nicola.key 2048

* Create certificate signing request (CSR)
openssl req -new -key nicola.key -out nicola.csr -subj "/CN=nico.benaz@gmail.com/O=devs/O=archs"

Common Name (CN) will be treated by Kubernetes as User
Organization (O) will be treated by Kubernetes as Group

* Send the CSR to the administrator




**********
  ADMIN
**********

* Admin may check the content and the declared groups
openssl req -new -key nicola.key -out nicola.csr -subj "/CN=nico.benaz@gmail.com/O=devs/O=archs"

Certificate Request:
    Data:
        Version: 1 (0x0)
        Subject: CN = nico.benaz@gmail.com, O = devs, O = archs
        Subject Public Key Info: [...]

* Download the cluster authority certificate (on your master in /etc/kubernetes/pki/ca.crt), which is a public distributable certificate.
You can see its content with the following:
openssl x509 -in ca.crt -noout -text

* The admin creates certificate from CSR using the cluster authority
openssl x509 -req -in nicola.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out nicola.crt -days 500

* Send ca.crt and nicola.crt to user

* The admin will grant the User or the Group in RoleBinding or ClusterRoleBinding. Take the role.yml as example:
kubectl create -f role.yml

Group binding:
kubectl create rolebinding devs-rb -n devs --group devs --role devs-reader

User binding:
kubectl create rolebinding devs-reader-nbenaglia -n devs --user nico.benaz@gmail.com --role devs-reader


**********
   USER
**********

* Add the new cluster to kubectl
kubectl config set-cluster devs-cluster --certificate-authority=ca.crt --embed-certs=true --server=https://<PUBLIC_ADDRESS_OF_CLUSTER>:6443

* Add the new credentials to kubectl
kubectl config set-credentials nicola --client-certificate=nicola.crt --client-key=nicola.key --embed-certs=true

* Add the new context to kubectl
kubectl config set-context dev-nicola --cluster=devs-cluster --user=nicola
