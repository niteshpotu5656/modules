output "s3_vpce_id"             { value = aws_vpc_endpoint.s3.id }
output "ecr_api_vpce_id"        { value = aws_vpc_endpoint.ecr_api.id }
output "ecr_dkr_vpce_id"        { value = aws_vpc_endpoint.ecr_dkr.id }
output "secretsmanager_vpce_id" { value = aws_vpc_endpoint.secretsmanager.id }