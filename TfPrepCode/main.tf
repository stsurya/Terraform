terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "Suryarg-01"
  location = "West Europe"
}

resource "azurerm_resource_group" "example02" {
  name     = "Suryarg-02"
  location = "West Europe"
}

resource "azurerm_storage_account" "example" {
  name                     = "sauks01surya"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
