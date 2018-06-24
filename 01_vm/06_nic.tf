resource "azurerm_network_interface" "dse_nic" {
  count = "${length(local.vmlist)}"

  "ip_configuration" {
    name = "dse_${element(local.vmlist, count.index)}_nic_config"
    private_ip_address_allocation = "dynamic"
    subnet_id = "${azurerm_subnet.dse_main_subnet.id}"
    public_ip_address_id = "${element(local.vmlist, count.index) == "m1" ? azurerm_public_ip.dse_oper_public_ip.id : ""}"
  }
  location = "${var.resource_location}"
  name = "dse_nic_${element(local.vmlist, count.index)}"
  resource_group_name = "${azurerm_resource_group.dse_rg.name}"
  network_security_group_id = "${element(local.vmlist, count.index) == "m1" ? azurerm_network_security_group.dse_oper_nsg.id : ""}"
  tags {
    environment = "DSE Demo"
  }
}