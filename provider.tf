# Configure Terraform
terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.15.0"
    }
  }
}


# Configure the Azure Active Directory Provider
provider "azuread" {
  tenant_id = "4d087de6-56a8-442e-9f9f-02bb31dee9b4"
}
