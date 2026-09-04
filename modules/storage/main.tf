resource "azurerm_storage_account" "main" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

resource "azurerm_storage_container" "main" {
  name                  = "${var.name}-container"
  storage_account_id    = azurerm_storage_account.main.id
  container_access_type = "private"
}