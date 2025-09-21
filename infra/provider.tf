terraform {
  required_version = ">=1.3.0"

  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstatestorage123"
    container_name       = "tfstate"
    key                  = "aks-dev.tfstate"
  }
}

provider "azurerm" {
  features {}
}
