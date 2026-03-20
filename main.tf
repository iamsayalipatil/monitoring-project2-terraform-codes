# Create monitoring namespace
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

# Deploy Prometheus via Helm
resource "helm_release" "prometheus" {
  name       = "prometheus2"
  chart      = "prometheus"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  repository = "https://prometheus-community.github.io/helm-charts"
  version    = "28.14.0"
}

# Deploy Grafana via Helm
resource "helm_release" "grafana" {
  name       = "grafana2"
  chart      = "grafana"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  repository = "https://grafana.github.io/helm-charts"
  version    = "6.17.5"

set {
    name  = "podSecurityPolicy.enabled"
    value = "false"
  }

  set {
    name  = "rbac.pspEnabled"
    value = "false"
  }
}