resource "azurerm_virtual_network" "hub_vnet" {
  name                = "hub-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_virtual_network" "spoke_vnet" {
  name                = "spoke-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                       = "hub-to-spoke"
  resource_group_name        = var.resource_group_name
  virtual_network_name       = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id  = azurerm_virtual_network.spoke_vnet.id
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                       = "spoke-to-hub"
  resource_group_name        = var.resource_group_name
  virtual_network_name       = azurerm_virtual_network.spoke_vnet.name
  remote_virtual_network_id  = azurerm_virtual_network.hub_vnet.id
  allow_virtual_network_access = true
}

resource "azurerm_private_dns_zone" "sql_private_dns" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.sql_private_dns.name
  virtual_network_id    = azurerm_virtual_network.spoke_vnet.id
}
