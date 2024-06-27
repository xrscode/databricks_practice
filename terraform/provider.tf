# Specify Azure as designated provider:
provider "azurerm" {
    features {}
}

# Define new resource group:
resource "azurerm_resource_group" "data_lake" {
    name = "data_lake_resource"
    location = "UK south"
}
