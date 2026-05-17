resource "aws_iam_role" "flow_log" {
  name = "${{var.account_name}}-${{var.environment}}-flow-log-role"
  assume_role_policy = jsonencode({{
    Version = "2012-10-17"
    Statement = [{{
      Effect    = "Allow"
      Principal = {{ Service = "vpc-flow-logs.amazonaws.com" }}
      Action    = "sts:AssumeRole"
    }}]
  }})
  tags = var.tags
}

resource "aws_iam_role_policy" "flow_log" {
  name   = "flow-log-s3-policy"
  role   = aws_iam_role.flow_log.id
  policy = jsonencode({{
    Version = "2012-10-17"
    Statement = [{{
      Effect   = "Allow"
      Action   = ["s3:PutObject"]
      Resource = "${{var.log_bucket_arn}}/vpc-flow-logs/*"
    }}]
  }})
}

resource "aws_flow_log" "main" {
  vpc_id               = var.vpc_id
  traffic_type         = "ALL"
  log_destination_type = "s3"
  log_destination      = "${{var.log_bucket_arn}}/vpc-flow-logs/"
  iam_role_arn         = aws_iam_role.flow_log.arn
  tags                 = merge(var.tags, {{ Name = "${{var.account_name}}-${{var.environment}}-flow-log" }})
}