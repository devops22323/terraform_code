terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "DmcCorpTest"
  }
  workspaces {
    prefix = "terraform_code"
  }


}
