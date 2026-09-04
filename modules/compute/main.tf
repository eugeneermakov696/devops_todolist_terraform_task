resource "azurerm_network_interface" "main" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id
  }
}



resource "azurerm_linux_virtual_machine" "main" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  provisioner "file" {
    source      = "${path.root}/install-app.sh"
    destination = "/home/${azurerm_linux_virtual_machine.main.admin_username}/install-app.sh"

    connection {
      type        = "ssh"
      user        = var.admin_username
      private_key = file("${path.root}/ssh/azure_vm_ssh")
      host        = var.public_ip_address
    }
  }
}

resource "azurerm_virtual_machine_extension" "example" {
  name                 = "customScript"
  virtual_machine_id   = azurerm_linux_virtual_machine.main.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
 {
  "commandToExecute": "chmod +x /home/${azurerm_linux_virtual_machine.main.admin_username}/install-app.sh && /home/${azurerm_linux_virtual_machine.main.admin_username}/install-app.sh"
 }
SETTINGS

}