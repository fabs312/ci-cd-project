# Variable for Azure Resource Group Name
variable "resource_group_name" {
  description = "The name of the Azure Resource Group where the networking resources will be deployed."
  type        = string
  default     = "default-resource-group"
}

# Variable for Azure Region Location
variable "location" {
  description = "The Azure region where the networking resources will be deployed."
  type        = string
  default     = "East US"
}

# Variable for Virtual Network Address Space
variable "vnet_address_space" {
  description = "The address space for the Virtual Network (VNet) in CIDR notation."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}
