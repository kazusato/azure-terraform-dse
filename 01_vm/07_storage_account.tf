resource "random_id" "storage_account_random_id" {
  keepers {
    resource_group = "${azurerm_resource_group.dse_rg.name}"
  }
  byte_length = 8
}

resource "azurerm_storage_account" "dse_storage_account" {
  account_replication_type = "LRS"
  account_tier = "Standard"
  location = "${var.resource_location}"
  name = "diag${random_id.storage_account_random_id.hex}"
  resource_group_name = "${azurerm_resource_group.dse_rg.name}"
  tags {
    environment = "DSE Demo"
  }
}