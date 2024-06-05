resource "azurerm_firewall" "firewall" {
  name                = "firewall"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.subnet_firewall.id
    private_ip_address   = "10.0.1.4"
  }

  depends_on = [
    azurerm_subnet.subnet_firewall
  ]
}

resource "azurerm_firewall_network_rule_collection" "firewall_rule" {
  name                = "firewall-rule"
  resource_group_name = var.resource_group_name
  azure_firewall_name = azurerm_firewall.firewall.name
  priority            = 100
  action              = "Allow"

  rule {
    name                  = "AllowSQL"
    description           = "Allow SQL traffic"
    protocol              = "TCP"
    source_addresses      = ["*"]
    destination_addresses = ["10.1.1.0/24"]
    destination_ports     = ["1433"]
  }
}
