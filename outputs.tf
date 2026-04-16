output "rg_id" {
    value = azurerm_resource_group.example_rg.id
}

output "kv_id" {
    value = azurerm_key_vault.example_kv.id
}

output "kv_name" {
    value = azurerm_key_vault.example_kv.name
}

output "kv_url" {
    value = azurerm_key_vault.example_kv.vault_uri  
}
