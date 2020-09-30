
provider "kubernetes" {
    config_context_cluster   = "minikube"
}


resource "kubernetes_deployment" "wordpress" {
  metadata {
    name = "wordpress-deployment"
    labels = {
      App = "wordpress"
    }
  }
  spec {
  replicas = 2
    selector{
        match_labels = {
           App = "wordpress"
      }
    }
     template {
        metadata {
         labels = {
             App = "wordpress"
         }
        }
       spec {
          container {
               image = "wordpress"
               name  = "mywordpress"

             resources {
                limits {
                  cpu    = "1"
                  memory = "1536Mi"
               }
               requests {
                  cpu    = "0.5"
                  memory = "1024Mi"
            }
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "service" {
  metadata {
    name = "wp-nodeport"
  }
  spec {
    selector = {
      App = kubernetes_deployment.wordpress.spec.0.template.0.metadata[0].labels.App
    }
    port {
      node_port   = 30100
      port        = 80
      target_port = 80
    }
    type = "NodePort"
   }
}
