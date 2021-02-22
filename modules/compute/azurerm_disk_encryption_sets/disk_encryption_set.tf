resource "azurecaf_name" "des" {

  name          = var.name
  resource_type = "azurerm_disk_encryption_set"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_disk_encryption_set" "des" {
  name                = azurecaf_name.des.result
  resource_group_name = var.resource_group_name
  location            = var.location
  key_vault_key_id    = var.keyvault_key_id
  tags                = local.tags

  identity {
    type = "SystemAssigned"
  }



}