# Required for databricks to work!
terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "1.0.0"
    }
  }
}