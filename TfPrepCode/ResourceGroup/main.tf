resource "azurerm_resource_group" "example" {
  name     = "${var.resource_group_name}-01"
  location = var.location
}
