variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}

variable "location" {
  type        = string
  description = "Resources location in Azure"
  default     = "francecentral"  # common free-tier region
}

variable "cluster_name" {
  type        = string
  description = "AKS name in Azure"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
  default     = "1.30.9" 
}

variable "system_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
  default     = 1
}

variable "acr_name" {
  type        = string
  description = "ACR name"
}
