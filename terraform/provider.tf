# Specify Azure as designated provider:
provider "azurerm" {
    features {}
}

provider "aws" {
  region = "eu-west-2"
  # other configuration settings as needed
}

# Access Secret Token
data "aws_secretsmanager_secret" "databricks_token" {
  name = "databricks_practice"
}

# Define new resource group:
resource "azurerm_resource_group" "data_lake" {
    name = "data_lake_resource"
    location = "UK south"
}

provider "databricks" {
  # Configure your Databricks provider credentials here
  host          = "https://adb-79098722112664.4.azuredatabricks.net"
  # Access token from AWS Secrets Manager
  token         = data.aws_secretsmanager_secret.databricks_token.secret_string
}