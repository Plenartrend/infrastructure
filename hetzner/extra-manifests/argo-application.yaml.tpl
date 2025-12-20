apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: plenartrend
  namespace: argocd
spec:
  project: default
  destination:
    server: https://kubernetes.default.svc
  source:
    repoURL: git@github.com:Plenartrend/infrastructure.git
    path: manifests
    targetRevision: HEAD
    directory:
      recurse: true
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
