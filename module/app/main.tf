provider "kubernetes" {}

resource "kubernetes_horizontal_pod_autoscaler" "nginx_hpas" {
  metadata {
    name = "nginx-hpas"
  }
  spec {
    max_replicas = 4
    min_replicas = 3
    scale_target_ref {
      kind = "ReplicationController"
      name = "${kubernetes_replication_controller.nginx.metadata.0.name}"
    }
  }
}
resource "kubernetes_replication_controller" "nginx" {
  metadata {
    name = "scalable-nginx-example"

    labels = {
      App = "ScalableNginxExample"
    }
  }

  spec {
    selector = {
      App = "ScalableNginxExample"
    }

    template {
      container {
        image = "nginx:1.7.8"
        name  = "example"

        port {
          container_port = 80
        }

        resources {
          limits {
            cpu    = "0.5"
            memory = "512Mi"
          }

          requests {
            cpu    = "250m"
            memory = "50Mi"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    name = "nginx-example"
  }

  spec {
    selector = {
      App = "${kubernetes_replication_controller.nginx.metadata.0.labels.App}"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "NodePort"
  }
}
