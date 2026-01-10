apiVersion: helm.cattle.io/v1
kind: HelmChart
metadata:
  name: kube-prometheus-stack
  namespace: kube-system
spec:
  repo: https://prometheus-community.github.io/helm-charts
  chart: kube-prometheus-stack
  targetNamespace: monitoring
  createNamespace: true
  valuesContent: |-
    # Grafana Configuration
    grafana:
      enabled: true
      adminUser: admin
      # Admin password will be set via secret or default
      adminPassword: admin
      ingress:
        enabled: false  # We'll create a separate ingress manifest
        annotations: {}
      service:
        type: ClusterIP
      persistence:
        enabled: true
        size: 10Gi
        storageClassName: local-path
    
    # Prometheus Configuration
    prometheus:
      enabled: true
      prometheusSpec:
        retention: 30d
        storageSpec:
          volumeClaimTemplate:
            spec:
              storageClassName: local-path
              accessModes: ["ReadWriteOnce"]
              resources:
                requests:
                  storage: 20Gi
        serviceMonitorSelectorNilUsesHelmValues: false
        podMonitorSelectorNilUsesHelmValues: false
        ruleSelectorNilUsesHelmValues: false
    
    # Alertmanager Configuration
    alertmanager:
      enabled: true
      alertmanagerSpec:
        storage:
          volumeClaimTemplate:
            spec:
              storageClassName: local-path
              accessModes: ["ReadWriteOnce"]
              resources:
                requests:
                  storage: 10Gi
    
    # Node Exporter (for node metrics)
    nodeExporter:
      enabled: true
    
    # Kube State Metrics
    kubeStateMetrics:
      enabled: true
    
    # Default rules and dashboards
    defaultRules:
      create: true
      rules:
        alertmanager: true
        etcd: true
        configReloaders: true
        general: true
        k8s: true
        kubeApiserverAvailability: true
        kubeApiserverBurnrate: true
        kubeApiserverHistogram: true
        kubeApiserverSlos: true
        kubelet: true
        kubeProxy: true
        kubePrometheusGeneral: true
        kubePrometheusNodeRecording: true
        kubernetesApps: true
        kubernetesResources: true
        kubernetesStorage: true
        kubernetesSystem: true
        kubeScheduler: true
        kubeStateMetrics: true
        network: true
        node: true
        nodeExporterAlerting: true
        nodeExporterRecording: true
        prometheus: true
        prometheusOperator: true
