terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-rg01"
    storage_account_name = "tfsa01storage"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
