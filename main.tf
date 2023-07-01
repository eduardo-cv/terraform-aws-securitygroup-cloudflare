##########################################################
#  Terraform -> Main
##########################################################
terraform {
  required_version = ">= 1.3.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.45.0"
    }
    http = ">= 3.2.1"
  }
}
##########################################################
#  Provedor AWS
##########################################################
provider "aws" {
  region = "sa-east-1"
}
##########################################################
# Lista CloudFlare -> ipv4
##########################################################
variable "allowed_ipv4_cloudflare" {
  type = list(string)
  default = [
    "103.21.244.0/22",
    "103.22.200.0/22",
    "103.31.4.0/22",
    "104.16.0.0/13",
    "104.24.0.0/14",
    "108.162.192.0/18",
    "131.0.72.0/22",
    "141.101.64.0/18",
    "162.158.0.0/15",
    "172.64.0.0/13",
    "173.245.48.0/20",
    "188.114.96.0/20",
    "190.93.240.0/20",
    "197.234.240.0/22",
    "198.41.128.0/17"
  ]
}
##########################################################
# Lista CloudFlare -> ipv6
##########################################################
variable "allowed_ipv6_cloudflare" {
  type = list(string)
  default = [
    "2400:cb00::/32",
    "2606:4700::/32",
    "2803:f800::/32",
    "2405:b500::/32",
    "2405:8100::/32",
    "2a06:98c0::/29",
    "2c0f:f248::/32"
  ]
}
##########################################################
resource "aws_security_group" "sg_cloudflare" {
  description = "sg_cloudflare"
  vpc_id      = "vpc-0944f8dd4423fd0c4" # Trocar aqui pelo id vpc
  name        = "sg_cloudflare"
  ingress {
    protocol         = "tcp"
    from_port        = 443
    to_port          = 443
    cidr_blocks      = var.allowed_ipv4_cloudflare
    ipv6_cidr_blocks = var.allowed_ipv6_cloudflare
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0", ]
  }
  tags = {
    Name = "terraform_sg_cloudflare"
  }
}

##########################################################
#  Comandos do terraform
##########################################################

# terraform init
# terraform apply --auto-approve
# terraform destroy --auto-approve
# terraform fmt -recursive
# terraform show
