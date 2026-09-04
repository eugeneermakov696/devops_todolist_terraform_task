terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "mate-azure-task-12"
    storage_account_name = "eugstacc"
    container_name       = "eugstacc-container"
    key                  = "mate-azure-task-12"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}