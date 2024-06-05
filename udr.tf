resource "azurerm_route_table" "route_table" {
  name                = "route-table"
  location            = var.location
  resource_group_name = var.resource_group_name

  route {
    name                   = "default-route"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.firewall.private_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "route_association" {
  subnet_id      = azurerm_subnet.subnet_sql.id
  route_table_id = azurerm_route_table.route_table.id
}
