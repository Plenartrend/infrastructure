helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
kubectl create namespace argocd
helm install argocd argo/argo-cd -n argocd

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KEY_FILE="$SCRIPT_DIR/sealed-secrets-key.yaml"

if [ -f "$KEY_FILE" ]; then
    echo "Found existing sealed-secrets-key.yaml - using existing private key"
    kubectl apply -f "$KEY_FILE"
    echo "Key applied. Controller will use this existing key."
else
    echo "No existing sealed-secrets-key.yaml found - controller will generate new key"
fi

kubectl apply -f https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.26.0/controller.yaml

# kubectl port-forward service/argocd-server -n argocd 8080:443                                                                                                                                                                                                                                                     
