resource "azurerm_resource_group" "example_rg" {
  name     = "{var.rg_prefix}-RG"
  location = "Australia East"
}

resource "azurerm_key_vault" "example_kv" {
  name                        = "examplekeyvault"
  location                    = azurerm_resource_group.example_rg
  resource_group_name         = azurerm_resource_group.example_rg
  enabled_for_disk_encryption = true
  tenant_id                   = "0d89afff-1fec-4d61-a83c-9f2cb19d043c"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}
