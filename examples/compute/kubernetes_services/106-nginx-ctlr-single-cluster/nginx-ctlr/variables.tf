variable "az_arm" {
  default = {}
}

variable "resource_group" {
  default = {}
}

variable vnets {
  default = {}
}

variable "storage" {
  default = {}
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

variable "vm_size" {
  description = "Specifies the size of the virtual machine."
  default     = "Standard_D4_V2"
}

variable "image" {
  default = {}
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
