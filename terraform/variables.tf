variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vpc_name" {
  type        = string
  default     = "netology-net"
  description = "VPC network&subnet name"
}

variable "public_subnet" {
  type        = string
  default     = "public"
  description = "subnet name"
}

variable "private_subnet" {
  type        = string
  default     = "private"
  description = "subnet name"
}

variable "resources_vm" {
  type = map(any)
  default = {
    cores         = 2
    memory        = 2
    core_fraction = 50
    disk_size     = 32
    disk_type     = "network-ssd"
  }
}

variable "vm_platform" {
  type        = string
  default     = "standard-v3"
  description = "platform of compute instanse"
}

variable "vm_preemptible" {
  type        = bool
  default     = true
  description = "preemptible"
}

variable "vm_nat" {
  type        = bool
  default     = true
  description = "nat enable"
}

variable "vm_user" {
  type        = string
  default     = "ubuntu"
  description = "default user"
}

variable "vm_family" {
  type        = string
  default     = "ubuntu-2404-lts-oslogin"
  description = "yandex_compute_image"
}

variable "db_set" {
  type = map(string)
  default = {
    user     = "db_user"
    password = "p@$$w0rD"
    db_name  = "netology_db"
    version  = "8.0"
    env      = "PRESTABLE"
    platform = "b1.medium"
  }
}

variable "metadata_map" {
  type = map(object({
    serial-port-enable = bool
    ssh-keys           = string
  }))
  default = {
    metadata = {
      serial-port-enable = true
      ssh-keys           = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIdGeVIrjr+DNhhCOKPA5Rl3Aui+Kwk8N3GHiUYs2H+F dervish@devops"
    }
  }
}
