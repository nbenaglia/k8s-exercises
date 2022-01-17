variable "ssh_keypair" {
  description = "SSH keypair to use for EC2 instance"
  default     = null
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  default     = "eu-west-1"
  type        = string
}

variable "aws_instance_type" {
  description = "AWS instance type"
  default     = "t3.medium"
  type        = string
}

variable "amis" {
  description = "Ubuntu 18.04 AMIs"
  type = map

  default = {
    eu-west-1 = "ami-07d8796a2b0f8d29c"
  }
}

variable "cluster-name" {
  default = "terraform-k8s-cks"
  type    = string
}
