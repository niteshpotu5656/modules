resource "aws_iam_instance_profile" "main" {
  name = "${{var.name}}-profile"
  role = var.iam_role_name
  tags = var.tags
}

resource "aws_instance" "main" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.sg_ids
  iam_instance_profile   = aws_iam_instance_profile.main.name
  user_data              = var.user_data
  monitoring             = true

  root_block_device {{
    encrypted   = true
    kms_key_id  = var.kms_key_arn
    volume_type = "gp3"
  }}

  metadata_options {{
    http_tokens = "required"
  }}

  tags = merge(var.tags, {{ Name = var.name }})
}