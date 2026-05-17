variable "vpc_id"       { description = "VPC ID" }
variable "subnet_ids"   { type = list(string); description = "Subnet IDs" }
variable "sg_id"        { description = "Security group ID" }
variable "route_table_ids" { type = list(string); description = "Route table IDs for gateway endpoints" }
variable "account_name" { description = "AWS account name" }
variable "environment"  { description = "Environment" }

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
