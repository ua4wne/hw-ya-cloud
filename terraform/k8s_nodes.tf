resource "yandex_kubernetes_node_group" "k8s-group-node" {
  cluster_id  = yandex_kubernetes_cluster.netology-k8s.id
  name        = "k8s-group-node"
  description = "k8s-group-node"
  version     = "1.29"
  instance_template {
    platform_id = var.vm_platform
    name        = "worker-a-{instance.short_id}"
    network_interface {
      subnet_ids = [yandex_vpc_subnet.subnet-public-a.id]
      # security_group_ids = [yandex_vpc_security_group.dev-sec-group.id]
    }
    resources {
      memory        = var.resources_vm["memory"]
      cores         = var.resources_vm["cores"]
      core_fraction = var.resources_vm["core_fraction"]
    }
    boot_disk {
      type = "network-hdd"
      size = var.resources_vm["disk_size"]
    }
    scheduling_policy {
      preemptible = var.vm_preemptible
    }
  }
  scale_policy {
    auto_scale {
      min     = 3
      max     = 6
      initial = 3
    }
  }
  allocation_policy {
    location { zone = "ru-central1-a" }
  }
  node_labels = {
    "autoscaled" = "true"
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true
  }
}
