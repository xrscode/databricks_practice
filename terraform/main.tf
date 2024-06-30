# Specify Azure as the designated provider
provider "azurerm" {
  features {}
  # Other Azure provider configuration settings as needed
}

# Specify AWS as the designated provider
provider "aws" {
  region = "eu-west-2"
  # Other AWS provider configuration settings as needed
}

# Define a new resource group in Azure
resource "azurerm_resource_group" "data_lake" {
  name     = "data_lake_resource"
  location = "UK South"
}

# Define the Databricks Workspace
resource "azurerm_databricks_workspace" "workspace" {
  name                = "databricks-practice"
  resource_group_name = azurerm_resource_group.data_lake.name
  location            = azurerm_resource_group.data_lake.location
  sku                 = "standard"

  tags = {
    Environment = "Production"
  }
}

# Access URL of the Databricks Workspace
data "azurerm_databricks_workspace" "workspace_data" {
  name                = azurerm_databricks_workspace.workspace.name
  resource_group_name = azurerm_resource_group.data_lake.name
}

# Access Secret Token from AWS Secrets Manager
data "aws_secretsmanager_secret" "databricks_token" {
  name = "dbpractice1"
}

# Retrieve the latest version of the secret
data "aws_secretsmanager_secret_version" "databricks_token_version" {
  secret_id = data.aws_secretsmanager_secret.databricks_token.id
}

# Specify Databricks as the designated provider
provider "databricks" {
  # Configure your Databricks provider credentials here
  host  = data.azurerm_databricks_workspace.workspace_data.workspace_url
  # Access token from AWS Secrets Manager
  token = data.aws_secretsmanager_secret_version.databricks_token_version.secret_string
}

# Creates a lowcost cluster:
# resource "databricks_cluster" "low_cost" {
#   cluster_name          = "minimal-cluster"
#   spark_version         = "7.3.x-scala2.12"
#   node_type_id          = "Standard_DS3_v2"
#   autotermination_minutes = 15
  
#   autoscale {
#     min_workers         = 1
#     max_workers         = 2
#   }
# }