# About
Run the Go program in Kubernetes.

# Start Local Kubernetes cluster

## Minikube
Install [Minikube](https://minikube.sigs.k8s.io/docs/). The following is based on these [steps](Install and tutorial
https://minikube.sigs.k8s.io/docs/start/):
1. Use brew: `brew install minikube`
1. Start minikube: `minikube start`
1. See the pods. Right now it is just the components of the control plane: `kubectl get po -A`


## Remove everything
1. Remove Service: `kubectl delete service goserver`
1. Confirm Service is deleted: `kubectl get service`
1. Remove Deployment: `kubectl delete deployment goserver`
1. Confirm Deployment is deleted: `kubectl get deployments`

## Install
1. Point my Docker environment to minikube (local k8s install) Docker registry:
`minikube docker-env`
1. Goto parent folder: `cd ..`
1. Build goserver image: `docker build -t goserver .`
1. List images: `docker images`
1. Goto k8s folder: `cd k8s`
1. Create a Deployment API Object: `kubectl apply -f goserver-deployment.yml` 
1. Confirm Deployment is created: `kubectl get deployments`
1. Expose a Deployment which creates a Service API Object: `kubectl expose deployment/goserver`
1. Confirm Service is deleted: `kubectl get service`
1. Create an interactive terminal session running inside Kubernetes: `kubectl run curl --image=radial/busyboxplus:curl -i --tty`
1. Exit the terminal session: `exit`
1. Resume terminal session: `kubectl attach curl -c curl -i -t`
1. Delete? `kubectl delete pod curl`

In that terminal session, determine the internal IP address for the goserver: `nslookup goserver`

Run curl: `curl <IP_ADDRESS>:8080`

Expose port to the laptop: `minikube service goserver`. A IP address and port will be shown. 

Run curl: `curl <IP_ADDRESS>:<PORT>`

# References
* https://matthewpalmer.net/kubernetes-app-developer/articles/kubernetes-apiversion-definition-guide.html