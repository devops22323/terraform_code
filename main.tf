resource "azuread_user" "example" {
  user_principal_name = "hitu@ksirichandansai2001gmail.onmicrosoft.com"
  display_name        = "Hitesh Bhargava        "
  mail_nickname       = "hitu"
  password            = random_password.password.result
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"

}
