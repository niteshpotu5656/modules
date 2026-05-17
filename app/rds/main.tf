resource "aws_db_subnet_group" "main" {{
  name       = "${{var.identifier}}-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = merge(var.tags, {{ Name = "${{var.identifier}}-subnet-group" }})
}}

resource "aws_db_instance" "main" {{
  identifier              = var.identifier
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  storage_type            = "gp3"
  storage_encrypted       = true
  kms_key_id              = var.kms_key_arn
  db_name                 = var.db_name
  username                = var.username
  password                = var.password
  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = var.sg_ids
  multi_az                = var.environment == "prod" ? true : false
  backup_retention_period = var.environment == "prod" ? 7 : 1
  deletion_protection     = var.environment == "prod" ? true : false
  skip_final_snapshot     = var.environment == "prod" ? false : true
  tags                    = merge(var.tags, {{ Name = var.identifier }})
}}