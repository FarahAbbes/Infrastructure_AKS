provider "azurerm" {
  features {}
  subscription_id = "6703d98b-5e14-4b3c-83e2-54b33e7ca076"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.78.0"
    }
  }
}