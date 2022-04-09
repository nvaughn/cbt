variable "access_key" {

}

variable "create_key_pair" {
  description = "Controls if key pair should be created"
  type        = bool
  default     = true
}

variable "instance_name" {

}

variable "key_name" {

}

variable "public_key" {

}

variable "region" {

}

variable "secret_key" {

}

variable "server_type" {

}

variable "subnet_zone" {

}

variable "vpc_cidr_block" {
  default     = "10.0.0.0/16"
  description = "CIDR Block for the VPC"
  type        = string
}

variable "class_name" {

}

variable "web_subnet" {
  default     = "10.0.10.0/24"
  description = "Web Subnet"
  type        = string
}

variable "instance_count" {
  default     = 1
  description = "Number of instances to provision"
  type        = number

}

variable "bucket_name" {
  type    = string
  default = "Demo"
}