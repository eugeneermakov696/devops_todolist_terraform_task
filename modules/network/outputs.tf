output "subnet_id" {
  value = one(azurerm_virtual_network.main.subnet).id
}

output "vn_id" {
  value = azurerm_virtual_network.main.id
}

output "dns_label" {
  value = azurerm_public_ip.main.domain_name_label
}

output "public_ip_address_id" {
  value = azurerm_public_ip.main.id
}

output "public_ip_address" {
  value = azurerm_public_ip.main.ip_address
}