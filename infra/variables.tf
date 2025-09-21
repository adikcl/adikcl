variable "location" {
  description = "Azure region"
  default     = "East US"
}

variable "resource_group" {
  description = "Resource Group name"
  default     = "rg-prod"
}

variable "cluster_name" {
  description = "AKS cluster name"
  default     = "prod-aks"
}
