resource "azurerm_resource_group" "rg02" {
  name     = "terraform-main"
  location = "West Europe"
}

resource "azurerm_storage_account" "sa02" {
  name                     = "tfsa02storage${count.index}"
  resource_group_name      = azurerm_resource_group.rg01.name
  location                 = azurerm_resource_group.rg01.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  count                    = 2
  lifecycle {
    create_before_destroy = true
  }
}
