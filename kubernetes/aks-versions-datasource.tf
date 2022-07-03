# Datasource to get Latest Azure AKS latest version
data "azurerm_kubernetes_service_versions" "current" {
  location        = azurerm_resource_group.rg.location
  include_preview = false
}