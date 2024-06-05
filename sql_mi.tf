resource "azurerm_subnet" "subnet_sql" {
  name                 = "subnet-sql"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.spoke_vnet.name
  address_prefixes     = ["10.1.1.0/24"]
  service_endpoints    = ["Microsoft.Sql"]
}

resource "azurerm_sql_managed_instance" "sql_mi" {
  name                         = var.sql_mi_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  subnet_id                    = azurerm_subnet.subnet_sql.id
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
  sku_name                     = "GP_Gen5_2"
  storage_size_in_gb           = 32
  collation                    = "SQL_Latin1_General_CP1_CI_AS"
}

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
