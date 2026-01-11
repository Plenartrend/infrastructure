apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  # Sealed Secrets
  # The Controller is deployed via 'extra_kustomize_deployment_commands' in kube.tf.
  # This file is not stored in the repository as it contains sensitive credentials.
  - sealed-secrets-key.yaml

  # ArgoCD
  - argocd-helm.yaml

  # CloudNativePG
  - cnpg-helm.yaml

  # Prometheus & Grafana
  - prometheus-helm.yaml

  # Chaos Mesh
  - chaos-mesh-helm.yaml

