terraform {
  backend "remote" {
    organization = "DmcCorpTest"

    workspaces {
      name = "terraform_code"
    }
  }
}

