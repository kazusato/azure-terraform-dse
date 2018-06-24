resource "azurerm_subnet" "dse_main_subnet" {
  address_prefix = "10.0.0.0/24"
  name = "dse_main_subnet"
  resource_group_name = "${azurerm_resource_group.dse_rg.name}"
  virtual_network_name = "${azurerm_virtual_network.dse_vnet.name}"
}