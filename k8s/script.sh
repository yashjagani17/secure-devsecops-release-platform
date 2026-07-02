kubectl apply -f k8s/namespace.yaml
kubectl get namespaces

kubectl apply -f k8s/deployment.yaml
kubectl get pods -n secure-devsecops

kubectl apply -f k8s/service.yaml
kubectl get svc -n secure-devsecops

kubectl apply -f k8s/ingress.yaml
kubectl get ingress -n secure-devsecops

MINIKUBE_IP=$(minikube ip)
HOSTNAME="secure-devsecops.local"

if grep -q "$HOSTNAME" /etc/hosts; then
    echo "Updating existing $HOSTNAME entry in /etc/hosts"
    sudo sed -i "/$HOSTNAME/d" /etc/hosts
fi

echo "$MINIKUBE_IP $HOSTNAME" | sudo tee -a /etc/hosts