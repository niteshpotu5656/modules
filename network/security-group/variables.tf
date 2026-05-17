variable "vpc_id"       { description = "VPC ID" }
variable "name"         { description = "Security group name" }
variable "description"  { description = "Security group description" }
variable "ingress_rules" {
  type = list(object({ from_port = number, to_port = number, protocol = string, cidr_blocks = list(string), description = string }))
  default = []
}
variable "egress_rules" {
  type = list(object({ from_port = number, to_port = number, protocol = string, cidr_blocks = list(string), description = string }))
  default = [{ from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"], description = "Allow all outbound" }]
}

variable "tags" {
  description = "All 24 mandatory tags that must be applied to every resource."
  type        = map(string)
  validation {
    condition = alltrue([
      for tag in [
        "AccountId", "AccountName", "AppId", "ApplicationType",
        "Environment", "Manager", "CostCenter", "BusinessUnit",
        "Department", "Project", "Owner", "CreatedBy", "CreatedDate",
        "LastModifiedBy", "LastModifiedDate", "Compliance",
        "DataClassification", "BackupPolicy", "MonitoringLevel",
        "PatchGroup", "SupportTeam", "Region", "Terraform",
        "TerraformModuleVersion"
      ] : contains(keys(var.tags), tag)
    ])
    error_message = "All 24 mandatory tags must be provided."
  }
}
