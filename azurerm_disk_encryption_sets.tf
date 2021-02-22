module "azurerm_disk_encryption_sets" {
  source   = "./modules/compute/azurerm_disk_encryption_sets"
  for_each = local.compute.azurerm_disk_encryption_sets

  global_settings     = local.global_settings
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = try(each.value.region, null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  name                = try(each.value.name, null)
  keyvault_key_id     = module.keyvault_keys[each.value.keyvault_key.key].id
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  tags                = try(each.value.tags, null)
}

output azurerm_disk_encryption_sets {
  value = module.azurerm_disk_encryption_sets

}