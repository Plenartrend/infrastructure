apiVersion: helm.cattle.io/v1
kind: HelmChart
metadata:
  name: chaos-mesh
  namespace: kube-system
spec:
  repo: https://charts.chaos-mesh.org
  chart: chaos-mesh
  targetNamespace: chaos-mesh
  createNamespace: true
  valuesContent: |-
  
    # Chaos Daemon
    chaosDaemon:
      runtime: containerd
      socketPath: /run/k3s/containerd/containerd.sock
      resources:
        limits:
          cpu: 500m
          memory: 1Gi
        requests:
          cpu: 100m
          memory: 128M