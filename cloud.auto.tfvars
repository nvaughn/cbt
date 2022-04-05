instance_name  = "CSA Demo Instance"
key_name       = "CSA_SSH_KEY" #CSA_SSH_KEY #DEV_SSH_KEY
public_key     = "/home/mercury/Projects/TERRAFORM/CSA/CSA_RSA.pub"
region         = "us-east-1"
server_type    = "t2.micro"
subnet_zone    = "us-east-1a"
vpc_cidr_block = "10.0.0.0/16"
class_name     = "Demo Class"
web_subnet     = "10.0.100.0/24"
instance_count = 3


#TF_LOG_CORE       = "info"
#TF_LOG_PROVIDER   = "DEBUG"
#TF_LOG_PATH       = "terraform.log"
