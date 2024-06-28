# Create databricks workspace
resource "azurerm_databricks_workspace" "workspace" {
  name                = "databricks-practice"
  resource_group_name = azurerm_resource_group.data_lake.name
  location            = azurerm_resource_group.data_lake.location
  sku                 = "standard"

  tags = {
    Environment = "Production"
  }
}

# Create resource cluster
# resource "databricks_cluster" "low_cost" {
#   cluster_name          = "minimal-cluster"
#   spark_version         = "7.3.x-scala2.12"
#   node_type_id          = "Standard_DS3_v2"  # Example of a cost-effective VM type
#   autotermination_minutes = 15
#   # Specify additional cluster configurations as needed
#   autoscale {
#     min_workers         = 2
#     max_workers         = 8
#   }
# }



