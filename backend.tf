terraform {
  backend "remote" {
    hostname     = "app.terrafrom.io"
    organization = "DmcCorpTest"
  }
  workspaces {
    prefix = "terraform_code"
  }


}
