module "resource_grp" {
  source              = "./ResourceGroup"
  resource_group_name = "Surya"
  location            = "west europe"
}

module "storageAccount" {
  source               = "./StorageAccount"
  storage_account_name = var.storage_account_name[count.index]
  depends_on           = [module.resource_grp]
  resource_group_name  = module.resource_grp.rg_name_output
  location             = module.resource_grp.rg_location
  count                = 3
}

module "VirtualNetowrk" {
  source               = "./VirtualNetwork"
  address_space        = ["10.10.0.0/16"]
  virtual_network_name = "Vnet01"
  resource_group_name  = module.resource_grp.rg_name_output
  location             = module.resource_grp.rg_location
}
