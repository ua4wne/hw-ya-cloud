// создание сервисного аккаунта для kubernetes
resource "yandex_iam_service_account" "sa-kube" {
  name = "sa-kube"
  description = "sa-kube"
}

// Назначение роли сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = "${var.folder_id}"
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa-kube.id}"
  depends_on = [yandex_iam_service_account.sa-kube]
}

resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
  folder_id = "${var.folder_id}"
  role      = "k8s.clusters.agent"
  member    = "serviceAccount:${yandex_iam_service_account.sa-kube.id}"
  depends_on = [yandex_iam_service_account.sa-kube]
}

resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
 # Сервисному аккаунту назначается роль "container-registry.images.puller".
  folder_id = "${var.folder_id}"
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.sa-kube.id}"
  depends_on = [yandex_iam_service_account.sa-kube]
}

resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
 # Сервисному аккаунту назначается роль "container-registry.images.puller".
  folder_id = "${var.folder_id}"
  role      = "vpc.publicAdmin"
  member    = "serviceAccount:${yandex_iam_service_account.sa-kube.id}"
  depends_on = [yandex_iam_service_account.sa-kube]
}