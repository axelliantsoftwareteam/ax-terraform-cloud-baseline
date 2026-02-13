provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "baseline" {
  name     = "${var.project_name}-${var.environment}-rg"
  location = var.location

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_virtual_network" "baseline" {
  name                = "${var.project_name}-${var.environment}-vnet"
  address_space       = ["10.50.0.0/16"]
  location            = azurerm_resource_group.baseline.location
  resource_group_name = azurerm_resource_group.baseline.name
}
