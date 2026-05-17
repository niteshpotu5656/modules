variable "bus_name"     { description = "EventBridge bus name" }
variable "rule_name"    { description = "EventBridge rule name" }
variable "event_pattern" { description = "JSON event pattern" }
variable "target_arn"   { description = "Target resource ARN (Lambda, SQS, etc.)" }
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
