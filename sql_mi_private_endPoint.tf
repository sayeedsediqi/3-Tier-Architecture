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
