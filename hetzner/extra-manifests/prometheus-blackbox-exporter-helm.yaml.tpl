apiVersion: helm.cattle.io/v1
kind: HelmChart
metadata:
  name: prometheus-blackbox-exporter
  namespace: kube-system
spec:
  repo: https://prometheus-community.github.io/helm-charts
  chart: prometheus-blackbox-exporter
  targetNamespace: monitoring
  createNamespace: false
  valuesContent: |-
    
    serviceMonitor:
      enabled: true
      namespace: monitoring
      interval: 30s
      scrapeTimeout: 10s
      labels:
        release: kube-prometheus-stack
    
    config:
      modules:
        http_2xx:
          prober: http
          timeout: 5s
          http:
            preferred_ip_protocol: "ip4"
            valid_http_versions: ["HTTP/1.1", "HTTP/2.0"]
            valid_status_codes: [200, 204, 301, 302, 303, 307, 308]
            follow_redirects: true
            method: GET
        
        tcp_connect:
          prober: tcp
          timeout: 5s
          tcp:
            preferred_ip_protocol: "ip4"

