variable "name"            { description = "EC2 instance name" }
variable "ami_id"          { description = "AMI ID (shared from Prod Shared Services)" }
variable "instance_type"   { default = "t3.medium" }
variable "subnet_id"       { description = "Subnet to launch instance in" }
variable "sg_ids"          { type = list(string); description = "Security group IDs" }
variable "kms_key_arn"     { description = "KMS key ARN for EBS encryption" }
variable "iam_role_name"   { description = "IAM role name for EC2 instance profile" }
variable "user_data"       { default = "" }
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
