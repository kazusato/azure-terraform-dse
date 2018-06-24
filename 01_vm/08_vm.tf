resource "azurerm_availability_set" "dse_avail_set" {
  location = "${var.resource_location}"
  name = "dse_avail_set"
  managed = true
  resource_group_name = "${azurerm_resource_group.dse_rg.name}"
  platform_fault_domain_count = 2
  tags {
    environment = "DSE Demo"
  }
}

resource "azurerm_virtual_machine" "dse_vm" {
  count = "${length(local.vmlist)}"

  location = "${var.resource_location}"
  name = "dse_vm_${element(local.vmlist, count.index)}"
  network_interface_ids = ["${element(azurerm_network_interface.dse_nic.*.id, count.index)}"]
  resource_group_name = "${azurerm_resource_group.dse_rg.name}"
  "storage_os_disk" {
    create_option = "FromImage"
    name = "dse_vm_${element(local.vmlist, count.index)}_os_disk"
    caching = "ReadWrite"
    managed_disk_type = "Standard_LRS"
  }
  storage_image_reference {
    publisher = "OpenLogic"
    offer = "CentOS"
    sku = "7.3"
    version = "latest"
  }
  os_profile {
    admin_username = "dseadmin"
    computer_name = "dse${element(local.vmlist, count.index)}"
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path = "/home/dseadmin/.ssh/authorized_keys"
      key_data = "${file("nogit/id_rsa.pub")}"
    }
  }
  boot_diagnostics {
    enabled = true
    storage_uri = "${azurerm_storage_account.dse_storage_account.primary_blob_endpoint}"
  }
  vm_size = "Standard_D2_v3"
  availability_set_id = "${substr(element(local.vmlist, count.index), 0, 1) == "m" ? azurerm_availability_set.dse_avail_set.id : ""}"
  tags {
    environment = "DSE Demo"
  }
}