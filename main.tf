module "resource_group" {
  source   = "./modules/resource_group"
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source                      = "./modules/network"
  vm-name                     = var.vm_name
  location                    = var.location
  resource_group_name         = module.resource_group.resource_group_name
  address_space               = var.vnet_address_prefix
  subnet_name                 = var.subnet_name
  subnet_address_prefixes     = var.subnet_address_prefix
  nsg_name                    = var.network_security_group_name
  public_ip_name              = var.public_ip_address_name
  public_ip_allocation_method = "Dynamic"
  public_ip_domain_name_label = module.network.dns_label
}

module "compute" {
  source               = "./modules/compute"
  vm_name              = var.vm_name
  location             = var.location
  resource_group_name  = module.resource_group.resource_group_name
  subnet_id            = module.network.subnet_id
  admin_username       = "eugeneadmin"
  ssh_key_path         = "${path.root}/ssh/azure_vm_ssh.pub"
  public_ip_address    = module.network.public_ip_address
  public_ip_address_id = module.network.public_ip_address_id
}

module "storage" {
  source              = "./modules/storage"
  name                = "eugstacc"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
}