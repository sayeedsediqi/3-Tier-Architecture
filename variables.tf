variable "location" {
  description = "The Azure region to deploy resources."
  default     = "Canada Central"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  default     = "rg-woocommerce"
}

variable "webapp_name" {
  description = "The name of the web app."
  default     = "woocommerce-app"
}

variable "sql_mi_name" {
  description = "The name of the SQL Managed Instance."
  default     = "woocommerce-sql-mi"
}

variable "admin_username" {
  description = "Admin username for SQL Managed Instance."
}

variable "admin_password" {
  description = "Admin password for SQL Managed Instance."
  sensitive   = true
}
