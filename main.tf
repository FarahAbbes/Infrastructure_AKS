resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_role_assignment" "role_acrpull" {
  scope                             = azurerm_container_registry.acr.id
  role_definition_name              = "AcrPull"
  principal_id                      = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  skip_service_principal_aad_check = true

  depends_on = [
    azurerm_container_registry.acr,
    azurerm_kubernetes_cluster.aks
  ]
}


resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = "Basic"   # important for cost saving
  admin_enabled       = false
}


resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.cluster_name

  default_node_pool {
  name       = "system"
  node_count = var.system_node_count  # should be 1 for free tier testing
  vm_size    = "Standard_B2s"         # smallest VM supported in AKS, cheaper
  type       = "VirtualMachineScaleSets"
  # omit zones to reduce cost & complexity
}

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "Standard"
    network_plugin    = "kubenet" # CNI
  }
}