# Terraform Modules

Reusable Terraform modules for all AWS infrastructure.
Versioned with Git tags (e.g. v1.0.0).

## Network Modules
| Module | Resources |
|---|---|
| `network/vpc` | aws_vpc |
| `network/subnets` | aws_subnet (public/private/db), IGW, route tables |
| `network/nat` | aws_nat_gateway, aws_eip |
| `network/kms` | aws_kms_key, aws_kms_alias |
| `network/security-group` | aws_security_group |
| `network/tgw` | TGW VPC attachment, static routes |
| `network/ssm` | SSM, SSMMessages, EC2Messages VPC endpoints |
| `network/vpce` | S3, ECR API/DKR, Secrets Manager VPC endpoints |
| `network/vpc-flow-logs` | aws_flow_log → centralised Log Account S3 |

## App Infra Modules
| Module | Resources |
|---|---|
| `app/ec2` | aws_instance, IAM instance profile |
| `app/eks` | aws_eks_cluster, aws_eks_node_group |
| `app/rds` | aws_db_instance, aws_db_subnet_group |
| `app/alb` | Application Load Balancer, target group, listener |
| `app/nlb` | Network Load Balancer, target group, listener |
| `app/sqs` | aws_sqs_queue + DLQ |
| `app/sns` | aws_sns_topic |
| `app/eventbridge` | Event bus, rule, target |
| `app/ecr` | aws_ecr_repository + lifecycle policy |
| `app/secrets-manager` | aws_secretsmanager_secret + version |

## Versioning
All modules are referenced by Git tag in pipelines:
```hcl
source = "git::https://github.com/AI-with-Nitesh/modules//network/vpc?ref=v1.0.0"
```

## Mandatory Tags
Every module enforces all 24 mandatory tags via input validation.
