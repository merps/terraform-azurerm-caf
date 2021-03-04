
variable "ARM_CLIENT_ID" {
  description = "appId or client_id of the service principal with a 'Contributor' role."
  default     = ""
}
variable "ARM_CLIENT_SECRET" {
  description = "password or client secret of the service principal."
  default     = ""
}
variable "ARM_SUBSCRIPTION_ID" {
  description = "Subscription Id."
  default     = ""
}
variable "ARM_TENANT_ID" {
  description = "Tenant Id."
  default     = ""
}

variable "resource_group" {
  description = "Existing Resource Group."
  default     = ""
}

variable "prefix" {
  description = "string to prefix the name of created resources."
  default     = "nginx-"
}

variable "hostname" {
  description = "Virtual machine hostname. Used for local hostname, DNS, and storage-related names."
  default     = "controller"
}

variable "location" {
  description = "The region where the virtual network is created."
  default     = "eastus"
}

variable "virtual_network_name" {
  description = "The name for your virtual network."
  default     = "my-vnet"
}


variable "subnet_name" {
  description = "Name of the subnet where to connect the NIC of the controller."
  default     = ""
}

variable "storage_account_tier" {
  description = "Defines the storage tier. Valid options are Standard and Premium."
  default     = "Standard"
}

variable "storage_replication_type" {
  description = "Defines the replication type to use for this storage account. Valid options include LRS, GRS etc."
  default     = "LRS"
}

variable "vm_size" {
  description = "Specifies the size of the virtual machine."
  default     = "Standard_D4_V2"
}

variable "image_publisher" {
  description = "Name of the publisher of the image (az vm image list)"
  default     = "Canonical"
}

variable "image_offer" {
  description = "Name of the offer (az vm image list)"
  default     = "UbuntuServer"
}

variable "image_sku" {
  description = "Image SKU to apply (az vm image list)"
  default     = "18.04-LTS"
}

variable "image_version" {
  description = "Version of the image to apply (az vm image list)"
  default     = "latest"
}

variable "admin_username" {
  description = "Administrator user name"
  default     = "chmainy"
}

variable "admin_password" {
  description = "Administrator password"
  default     = "KeepItStr0ngEnough"
}

variable "admin_ssh_key" {
  description 	= "SSH Public Key"
  default	= ""
}

variable "source_network" {
  description = "Allow access from this network prefix. Defaults to '*'."
  default     = "*"
}

variable "ctrltarball" {
  description = "URL (non authenticated) to the tar.gz archive of the controller."
  default     = "*"
}
variable "ctrlfqdn" {
  description = "target fqdn of the controller."
  default     = "*"
}
variable "vmusername" {
  description = "username for the VM admin account."
  default     = "*"
}
variable "useremail" {
  description = "Email address of the username for controller UI and API."
  default     = "*"
}
variable "ctrlpassword" {
  description = "Password to access the controller UI and API."
  default     = "*"
}
variable "license" {
  description = "License Access Token."
  default     = "*"
}
