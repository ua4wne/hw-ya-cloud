resource "yandex_kms_symmetric_key" "secret-key" {
  name              = "s-key"
  description       = "ключ для шифрования"
  default_algorithm = "AES_256"
  rotation_period   = "8760h" // equal to 1 year
}