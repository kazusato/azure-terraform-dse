resource "azurerm_virtual_network" "dse_vnet" {
  address_space = ["10.0.0.0/16"]
  location = "${var.resource_location}"
  name = "dse_vnet"
  resource_group_name = "${azurerm_resource_group.dse_rg.name}"
  tags {
    environment = "DSE Demo"
  }
}