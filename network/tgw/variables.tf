variable "vpc_id"           { description = "VPC ID to attach to TGW" }
variable "subnet_ids"       { type = list(string); description = "Subnet IDs for TGW attachment" }
variable "tgw_id"           { description = "Transit Gateway ID from Shared Services" }
variable "static_routes"    { type = list(string); default = []; description = "Static CIDR routes to propagate" }
variable "account_name"     { description = "AWS account name" }
variable "environment"      { description = "Environment" }

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
