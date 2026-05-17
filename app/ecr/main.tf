resource "aws_ecr_repository" "main" {{
  name                 = var.name
  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration {{
    scan_on_push = true
  }}
  encryption_configuration {{
    encryption_type = "KMS"
    kms_key         = var.kms_key_arn
  }}
  tags = merge(var.tags, {{ Name = var.name }})
}}

resource "aws_ecr_lifecycle_policy" "main" {{
  repository = aws_ecr_repository.main.name
  policy = jsonencode({{
    rules = [{{
      rulePriority = 1
      description  = "Keep last ${{var.image_count_limit}} images"
      selection = {{
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = var.image_count_limit
      }}
      action = {{ type = "expire" }}
    }}]
  }})
}}