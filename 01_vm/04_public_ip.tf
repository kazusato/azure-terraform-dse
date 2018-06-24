resource "azurerm_public_ip" "dse_oper_public_ip" {
  location = "${var.resource_location}"
  name = "dse_oper_public_ip"
  public_ip_address_allocation = "dynamic"
  resource_group_name = "${azurerm_resource_group.dse_rg.name}"
  tags {
    environment = "DSE Demo"
  }
}