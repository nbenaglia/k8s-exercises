## HORIZONTAL POD AUTOSCALER

Run & expose php-apache server:
* docker build -t hpa-example .
* kubectl run php-apache --image=k8s.gcr.io/hpa-example --requests=cpu=200m --expose --port=80

Create Horizontal Pod Autoscaler:
* kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10
deployment "php-apache" autoscaled

* kubectl get hpa
NAME         REFERENCE                     TARGET    MINPODS   MAXPODS   REPLICAS   AGE
php-apache   Deployment/php-apache/scale   0% / 50%  1         10        1          18s

Increase load:
* kubectl run -i --tty load-generator --image=busybox /bin/sh

Hit enter for command prompt
* while true; do wget -q -O- http://php-apache.default.svc.cluster.local; done

Stop load:
* kubectl get hpa
NAME         REFERENCE                     TARGET       MINPODS   MAXPODS   REPLICAS   AGE
php-apache   Deployment/php-apache/scale   0% / 50%     1         10        1          11m

* kubectl get deployment php-apache
NAME         DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
php-apache   1         1         1            1           27m



# Reference: https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/
