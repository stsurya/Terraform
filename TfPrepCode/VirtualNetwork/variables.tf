variable "subnets" {
  type = list(object({
    name           = string
    address_prefix = string
  }))
  default = [
    { name = "snet1", address_prefix = "10.10.1.0/24" },
    { name = "snet2", address_prefix = "10.10.2.0/24" },
    { name = "snet3", address_prefix = "10.10.3.0/24" },
    { name = "snet4", address_prefix = "10.10.4.0/24" }
  ]
}

variable "virtual_network_name" {
  type = string
}


variable "address_space" {
  type = list(string)
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}
