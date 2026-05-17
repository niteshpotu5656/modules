output "instance_id"         { value = aws_instance.main.id }
output "private_ip"          { value = aws_instance.main.private_ip }
output "instance_profile_arn"{ value = aws_iam_instance_profile.main.arn }