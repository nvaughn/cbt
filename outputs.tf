output "class_name" {
  description = "Name of class being provisioned"
  value       = var.class_name
}

output "ec2_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = module.ec2_instance[*].public_ip
}

output "creation_timestamp" {
  description = "Date infrastructure provisioned"
  value       = local.Creation_Time
}



