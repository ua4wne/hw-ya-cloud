locals {
  cloud_id    = var.cloud_id
  folder_id   = var.folder_id
  k8s_version = "1.30"
  sa_name     = "sa-kube"
}

// создание кластера
resource "yandex_kubernetes_cluster" "netology-k8s" {
  name      = "netology-k8s"
  network_id = yandex_vpc_network.dev-net.id
  master {
    version = local.k8s_version
    public_ip = var.vm_nat
    regional {
      region = "ru-central1"
      location {
        zone      = yandex_vpc_subnet.subnet-public-a.zone
        subnet_id = yandex_vpc_subnet.subnet-public-a.id
      }
      location {
        zone      = yandex_vpc_subnet.subnet-public-b.zone
        subnet_id = yandex_vpc_subnet.subnet-public-b.id
      }
      location {
        zone      = yandex_vpc_subnet.subnet-public-d.zone
        subnet_id = yandex_vpc_subnet.subnet-public-d.id
      }
    }
    security_group_ids = ["${yandex_vpc_security_group.dev-sec-group.id}"]
    
  }
  service_account_id      = yandex_iam_service_account.sa-kube.id
  node_service_account_id = yandex_iam_service_account.sa-kube.id
  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
    yandex_resourcemanager_folder_iam_member.vpc-public-admin,
    yandex_resourcemanager_folder_iam_member.images-puller
  ]
  kms_provider {
    key_id = yandex_kms_symmetric_key.secret-key.id
  }
  
}
