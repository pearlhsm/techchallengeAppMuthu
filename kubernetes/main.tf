# Create a resource group for postgreSQL
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create an azure kubernets for Techchallenge application
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.cluster_name
  node_resource_group = var.node_resource_group

  default_node_pool {
    name                 = "agentpool"
    node_count           = var.agent_count
    vm_size              = "Standard_DS2_v2"
    orchestrator_version = data.azurerm_kubernetes_service_versions.current.latest_version
    type                 = "VirtualMachineScaleSets"
    zones                = ["1"]
    enable_auto_scaling  = true
    max_count            = 2
    min_count            = 1
    os_disk_size_gb      = 30
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "azure"
  }
}

# Create an azure database for postgres server
resource "azurerm_postgresql_server" "default" {
  name                             = "postgresql-techchallenge-server"
  location                         = var.location
  resource_group_name              = azurerm_resource_group.rg.name
  sku_name                         = "GP_Gen5_2"
  storage_mb                       = 5120
  backup_retention_days            = 7
  geo_redundant_backup_enabled     = false
  auto_grow_enabled                = true
  administrator_login              = "techchallengeuser"
  administrator_login_password     = "Postgres!23"
  version                          = "11"
  ssl_enforcement_enabled          = false
  ssl_minimal_tls_version_enforced = "TLSEnforcementDisabled"
}

# Create an azure database for postgres
resource "azurerm_postgresql_database" "default" {
  name                = "app"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_server.default.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}


