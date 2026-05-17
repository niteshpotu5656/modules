variable "vpc_id"              { description = "VPC ID" }
variable "public_cidrs"        { type = list(string); description = "Public subnet CIDRs" }
variable "private_cidrs"       { type = list(string); description = "Private subnet CIDRs" }
variable "db_cidrs"            { type = list(string); description = "DB subnet CIDRs" }
variable "availability_zones"  { type = list(string); description = "AZs to deploy subnets" }
variable "account_name"        { description = "AWS account name" }
variable "environment"         { description = "Environment" }

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
