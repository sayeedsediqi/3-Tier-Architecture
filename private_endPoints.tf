resource "azurerm_private_endpoint" "sql_private_endpoint" {
  name                = "sql-private-endpoint"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = azurerm_subnet.subnet_sql.id
  private_service_connection {
    name                           = "sqlConnection"
    private_connection_resource_id = azurerm_sql_managed_instance.sql_mi.id
    subresource_names              = ["sqlManagedInstance"]
  }
}

resource "azurerm_private_dns_a_record" "sql_a_record" {
  name                = azurerm_sql_managed_instance.sql_mi.name
  zone_name           = azurerm_private_dns_zone.sql_private_dns.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.sql_private_endpoint.private_ip_address]
}

resource "azurerm_private_endpoint" "webapp_private_endpoint" {
  name                = "webapp-private-endpoint"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = azurerm_subnet.subnet_webapp.id
  private_service_connection {
    name                           = "webappConnection"
    private_connection_resource_id = azurerm_app_service.app_service.id
    subresource_names              = ["sites"]
  }
}

resource "azurerm_private_dns_a_record" "webapp_a_record" {
  name                = azurerm_app_service.app_service.name
  zone_name           = azurerm_private_dns_zone.webapp_private_dns.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.webapp_private_endpoint.private_ip_address]
}
