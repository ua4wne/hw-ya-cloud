resource "yandex_mdb_mysql_cluster" "ntl-mysql-cluster" {
  name                = "netology-mysql-cluster"
  environment         = var.db_set["env"]
  network_id          = yandex_vpc_network.dev-net.id
  version             = var.db_set["version"]
  security_group_ids  = [ "${yandex_vpc_security_group.dev-sec-group.id}" ] 
  deletion_protection = true

  resources {
    resource_preset_id = var.db_set["platform"]
    disk_type_id       = var.resources_vm["disk_type"]
    disk_size          = var.resources_vm["disk_size"]
  }

  host {
    zone      = var.default_zone
    subnet_id = yandex_vpc_subnet.subnet-private-30.id
    assign_public_ip = var.vm_nat
  }

  maintenance_window {
    type = "ANYTIME"
  }

  backup_window_start {
    hours   = 23
    minutes = 59
  }

  access {
    web_sql   = true
    data_lens = true
  }

}

resource "yandex_mdb_mysql_database" "netology-db" {
  cluster_id = yandex_mdb_mysql_cluster.ntl-mysql-cluster.id
  name       = var.db_set["db_name"]
  depends_on = [yandex_mdb_mysql_cluster.ntl-mysql-cluster]
}

resource "yandex_mdb_mysql_user" "dbuser" {
  cluster_id = yandex_mdb_mysql_cluster.ntl-mysql-cluster.id
  name       = var.db_set["user"]
  password   = var.db_set["password"]
  permission {
    database_name = var.db_set["db_name"]
    roles         = ["ALL"]
  }
  depends_on = [yandex_mdb_mysql_database.netology-db]
}