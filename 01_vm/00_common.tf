provider "azurerm" {}

locals {
  vmlist = ["m1", "m2", "m3"]
}

variable "resource_location" {
  default = "japaneast"
}

variable "custom_script_storage_account" {}
variable "custom_script_storage_access_key" {}
variable "custom_script_url" {}

variable "remote_state_storage_account" {}
variable "remote_state_container_name" {}
variable "remote_state_key" {}
variable "remote_state_access_key" {}
