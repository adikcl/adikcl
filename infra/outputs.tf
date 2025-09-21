output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "acr_name" {
  value = azurerm_container_registry.acr.login_server
}

output "keyvault_uri" {
  value = azurerm_key_vault.kv.vault_uri
}
