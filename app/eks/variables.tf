variable "cluster_name"    { description = "EKS cluster name" }
variable "k8s_version"     { default = "1.29" }
variable "subnet_ids"      { type = list(string) }
variable "sg_id"           { description = "Control plane security group" }
variable "kms_key_arn"     { description = "KMS key for secrets encryption" }
variable "node_instance_type" { default = "t3.medium" }
variable "node_desired"    { default = 2 }
variable "node_min"        { default = 1 }
variable "node_max"        { default = 4 }
variable "account_name"    { description = "AWS account name" }
variable "environment"     { description = "Environment" }

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
