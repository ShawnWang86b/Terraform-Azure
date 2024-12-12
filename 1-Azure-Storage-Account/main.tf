terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.12.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {
    
  }
  client_id =var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
  subscription_id = var.subscription_id
}

# Create a resource group
# The third one "appgrp" is label, label is for reference
resource "azurerm_resource_group" "appgrp" {
  name     = "app-group"
  location = "Australia East"
}

resource "azurerm_storage_account" "appstoreriawang0828" {
  name                     = "appstoreriawang0828"
  resource_group_name      = azurerm_resource_group.appgrp.name
  location                 = "Australia East"
  account_kind             = "BlobStorage"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "scripts" {
  name                  = "scripts"
  storage_account_name  = azurerm_storage_account.appstoreriawang0828.name
}

resource "azurerm_storage_blob" "ria" {
  name                   = "ria.txt"
  storage_account_name   = azurerm_storage_account.appstoreriawang0828.name
  storage_container_name = azurerm_storage_container.scripts.name
  type                   = "Block"
  source                 = "ria.txt"
}
