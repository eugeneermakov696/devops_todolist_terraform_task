variable "vm-name" {
  type        = string
  description = "The name of the virtual network."
}

variable "location" {
  type        = string
  description = "The location of the resource group."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "address_space" {
  type        = list(string)
  description = "The address space of the virtual network."
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet."
}

variable "subnet_address_prefixes" {
  type        = list(string)
  description = "The address prefixes of the subnet."
}

variable "nsg_name" {
  type        = string
  description = "The name of the network security group."
}

variable "public_ip_name" {
  type        = string
  description = "The name of the public IP."
}

variable "public_ip_allocation_method" {
  type        = string
  description = "The allocation method of the public IP."
}

variable "public_ip_domain_name_label" {
  type        = string
  description = "The domain name label of the public IP."
}