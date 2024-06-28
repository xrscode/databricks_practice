# Data lake for storing RAW and Processed Data

# Create storage account:
resource "azurerm_storage_account" "data_lake" {
    name = "databrickspractice5761"
    resource_group_name = azurerm_resource_group.data_lake.name
    location = azurerm_resource_group.data_lake.location
    account_tier = "Standard"
    account_replication_type = "LRS"
    # Enable hierarchical namespace
    # Allows creation of folders.
    is_hns_enabled           = true
} 

# Create blob storage:
resource "azurerm_storage_data_lake_gen2_filesystem" "my_lake" {
    name = "datalake"
    storage_account_id = azurerm_storage_account.data_lake.id
}

# Create RAW directory:
resource "azurerm_storage_data_lake_gen2_path" "raw_directory" {
    path = "RAW"
    filesystem_name = azurerm_storage_data_lake_gen2_filesystem.my_lake.name
    storage_account_id = azurerm_storage_account.data_lake.id
    resource = "directory"
}

# Upload JSON to RAW directory:
resource "azurerm_storage_blob" "json" {
    name = "RAW/dbdata.json"
    storage_account_name   = azurerm_storage_account.data_lake.name
    storage_container_name = azurerm_storage_data_lake_gen2_filesystem.my_lake.name
    type                   = "Block"  # Specify the blob type as "Block"
    source                 = "../data/dbdata.json"  # Path to JSON file
    depends_on = [
        azurerm_storage_data_lake_gen2_path.raw_directory
  ]
}