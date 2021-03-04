terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.43.0"
    }
  }
}

provider "azurerm" {
  # Configuration options

  subscription_id = var.ARM_SUBSCRIPTION_ID
  client_id       = var.ARM_CLIENT_ID
  client_secret   = var.ARM_CLIENT_SECRET
  tenant_id       = var.ARM_TENANT_ID

  features {}
}

data "azurerm_resource_group" "resourceGroup" {
  name     = var.resource_group
}

data "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  resource_group_name = data.azurerm_resource_group.resourceGroup.name
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.resourceGroup.name
}

# Security group to allow inbound access on port 80 (http) and 22 (ssh)
resource "azurerm_network_security_group" "nginx-NSG" {
  name                = "${var.prefix}-sg"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.resourceGroup.name

  security_rule {
    name                       = "HTTPS"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = var.source_network
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "SSH"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.source_network
    destination_address_prefix = "*"
  }
}

# A network interface. This is required by the azurerm_virtual_machine 
# resource. Terraform will let you know if you're missing a dependency.
resource "azurerm_network_interface" "nginx-nic" {
  name                      = "${var.prefix}nginx-nic"
  location                  = var.location
  resource_group_name       = data.azurerm_resource_group.resourceGroup.name

  ip_configuration {
    name                          = "${var.prefix}ipconfig"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.nginx-pip.id
  }
}

resource "azurerm_network_interface_security_group_association" "nic-nsg-assoc" {
  network_interface_id      = azurerm_network_interface.nginx-nic.id
  network_security_group_id = azurerm_network_security_group.nginx-NSG.id
}

resource "azurerm_public_ip" "nginx-pip" {
  name                         	= "${var.prefix}-ip"
  location                     	= var.location
  resource_group_name          	= data.azurerm_resource_group.resourceGroup.name
  allocation_method   		= "Dynamic"
  domain_name_label            	= var.hostname
}

resource "azurerm_linux_virtual_machine" "controller" {
  name                = "${var.hostname}-nginx"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.resourceGroup.name
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids         = [azurerm_network_interface.nginx-nic.id]
  #delete_os_disk_on_termination = "true"

  admin_ssh_key {
        username = "${var.admin_username}"
        public_key = file("~/.ssh/id_rsa.pub")
        #public_key = "${var.admin_ssh_key}"
        }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  os_disk {
    name                 = "${var.hostname}-osdisk"
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  # It's easy to transfer files or templates using Terraform.
  provisioner "file" {
    source      = "scripts/install-controller.sh"
    destination = "/home/${var.admin_username}/install-controller.sh"

    connection {
      type     = "ssh"
      user     = "${var.admin_username}"
#      password = "${var.admin_password}"
      private_key = file("~/.ssh/id_rsa")
      host     = "${azurerm_public_ip.nginx-pip.fqdn}"
    }
  }

  # This shell script starts our Apache server and prepares the demo environment.
  provisioner "remote-exec" {
    inline = [
	
      	"chmod +x /home/${var.admin_username}/install-controller.sh",
        "echo ${var.ctrltarball} > test.txt",
	"sh /home/${var.admin_username}/install-controller.sh ${var.ctrltarball} ${var.ctrlfqdn} ${var.vmusername} ${var.useremail} ${var.ctrlpassword} ${var.license}"
    ]

    connection {
      type     = "ssh"
      user     = var.admin_username
      #password = var.admin_password
      private_key = file("~/.ssh/id_rsa")
      host     = azurerm_public_ip.nginx-pip.fqdn
    }
  }
}

