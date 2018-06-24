resource "azurerm_virtual_machine_extension" "dse_vm_extension" {
  count = "${length(local.vmlist)}"

  location = "${var.resource_location}"
  name = "dse_vm_${element(local.vmlist, count.index)}"
  publisher = "Microsoft.Azure.Extensions"
  resource_group_name = "${azurerm_resource_group.dse_rg.name}"
  type = "CustomScript"
  type_handler_version = "2.0"
  virtual_machine_name = "${element(azurerm_virtual_machine.dse_vm.*.name, count.index)}"
  protected_settings = <<SETTINGS
    {
        "fileUris": ["${var.custom_script_url}"],
        "commandToExecute": "sh update-install-yums.sh",
        "storageAccountName": "${var.custom_script_storage_account}",
        "storageAccountKey": "${var.custom_script_storage_access_key}"
    }
SETTINGS

  tags {
    environment = "DSE Demo"
  }
}