resource "azurerm_virtual_network" "main" {
  name                = "vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name             = "default"
    address_prefixes = ["10.0.1.0/24"]
    security_group   = azurerm_network_security_group.main.id
  }
}

resource "azurerm_network_security_group" "main" {
  name                = "defaultnsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

   security_rule {
    name                       = "allow-app"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "random_integer" "dns_suffix" {
  min = 1000
  max = 9999
}


resource "azurerm_public_ip" "main" {
  name                = "linuxboxpip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  domain_name_label   = "matetask-${random_integer.dns_suffix.result}"
}