resource "azurerm_network_security_group" "nsg_sql" {
  name                = "nsg-sql"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowSQLInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["1433"]
    source_address_prefix      = "*"
    destination_address_prefix = "10.1.1.0/24"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.subnet_sql.id
  network_security_group_id = azurerm_network_security_group.nsg_sql.id
}
