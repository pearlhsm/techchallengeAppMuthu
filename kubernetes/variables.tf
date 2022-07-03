variable "ssh_public_key" {}

#Environment varaibles for Techchallenge application
variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Resource location"
}

variable "cluster_name" {
  type        = string
  description = "AKS cluster name"
}

variable "node_resource_group" {
  type        = string
  description = "Node resource group name"
}

variable "agent_count" {
  type        = number
  description = "Number of AKS worker nodes"
}





