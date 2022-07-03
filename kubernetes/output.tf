# Azure AKS outputs
output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "aks_fqdn" {
  value = azurerm_kubernetes_cluster.aks.fqdn
}

output "aks_node_rg" {
  value = azurerm_kubernetes_cluster.aks.resource_group_name
}

# Azure postgres database server name
output "azurerm_postgresql_server" {
  value = azurerm_postgresql_server.default.name
}

output "AKS_latest_version" {
  value = data.azurerm_kubernetes_service_versions.current.latest_version
}
