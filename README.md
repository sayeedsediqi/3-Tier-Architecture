# 3-Tier-Architecture

To create a complete Azure cloud-based infrastructure using Terraform for a custom WooCommerce-based product with a 3-tier architecture, we will utilize serverless technologies such as Azure Web Apps, App Service Plans, and SQL Managed Instances. 
Additionally, we will implement a hub-and-spoke network model with peering to a hub network and private DNS zones for Private EndPoints connectvity.


Terraform Directory Structure

terraform/
|-- main.tf
|-- provider.tf
|-- backend.tf
|-- variables.tf
|-- network.tf
|-- sql_mi.tf
|-- webapp.tf
|-- firewall.tf
|-- nsg.tf
|-- udr.tf
|-- private_endpoints.tf
|-- terraform.tfvars
azure-pipelines.yml

