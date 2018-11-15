## CONFIGMAPS AND SECRETS

# These kinds of resources can be updated in Kubernetes and applications should be designed to re-read configuration values in them
# (when exposed as volume).

# CONFIGMAP

The configMap resource provides a way to inject configuration data into Pods.
The data stored in a ConfigMap object can be referenced in a volume of type configMap and then consumed by containerized applications running in a Pod.

 From file simple-config.txt we're going to create a ConfigMap.
 We add some more parameters.

* kubectl create configmap my-config --from-file=simple-config.txt --from-literal=DESSERT="Jamwich" --from-literal=SALAD="Chicken Club Salad"

Now we see the ConfigMap from the resource in memory:
* kubectl get configmaps my-config -o yaml
* curl

Let's change the value of a variable (choose one):
* kubectl edit configmap my-config
* kubectl exec -ti poddoz-config -- bash
* cd /config
* cat <variable_name>

Only through mounted ConfigMaps is possible to have your variables updated when they changed. It takes a whole minute after the update to have them refreshed.



# SECRET

Generate certificates
* sudo openssl rsa -in privkey.pem -out new.cert.key
* sudo openssl x509 -in new.cert.csr -out new.cert.cert -req -signkey new.cert.key -days NNN
* sudo cp new.cert.cert my-cert.crt
* sudo cp new.cert.key my.key


We create a imagePullSecrets for docker credentials
* kubectl create secret docker-registry my-image-pull-secret --docker-username=pippo --docker-password=password --docker-email=email@domain.com

Secrets are stored on tmpfs volumes (RAM disks) and are not written to disk on nodes.
* kubectl create secret generic my-secret --from-file=my-cert.crt --from-file=my.key
* kubectl describe secrets my-secret
* kubectl create -f poddoz-secret.yml
* kubectl exec -ti poddoz-secret -- bash
* cd /tls
* cat my-cert.crt
