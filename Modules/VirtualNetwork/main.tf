resource "azurerm_virtual_network" "dynamic_block" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space

  dynamic "subnet" {
    for_each = var.subnets
    iterator = item
    content {
      name           = item.value.name
      address_prefix = item.value.address_prefix
    }
  }
}
