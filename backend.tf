terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "DmcCorpTest"

    workspaces {
      name = "terraform_code"
    }
  }
}
