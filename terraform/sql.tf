# This will create a SQL server and a SQL database

# Create SQL Server
resource "azurerm_mssql_server" "db_practice" {
    name = "databricks-practice-server"
    resource_group_name = azurerm_resource_group.data_lake.name
    location = azurerm_resource_group.data_lake.location
    version = "12.0"
    administrator_login = "sqladm"
    administrator_login_password = "Dylan5761"

    tags = {
        environment = "Production"
    }
}


# Create SQL database
resource "azurerm_sql_database" "databricksSQL" {
  name                = "databricks"
  resource_group_name = azurerm_resource_group.data_lake.name
  location            = azurerm_resource_group.data_lake.location
  server_name         = azurerm_mssql_server.db_practice.name  
  edition             = "Basic"
  collation           = "SQL_Latin1_General_CP1_CI_AS"

  tags = {
    environment = "Production"
  }
}

# Configure FIREWAL RULES
# Allows connection
resource "azurerm_sql_firewall_rule" "example" {
  name                = "allow-public-access"
  resource_group_name = azurerm_resource_group.data_lake.name
  server_name         = azurerm_mssql_server.db_practice.name
  # Allow any ip:
  start_ip_address    = "0.0.0.0"   
  end_ip_address      = "0.0.0.0"   
}