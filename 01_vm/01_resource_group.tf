resource "azurerm_resource_group" "dse_rg" {
  location = "${var.resource_location}"
  name = "dse_rg"
  tags {
    environment = "DSE Demo"
  }
}