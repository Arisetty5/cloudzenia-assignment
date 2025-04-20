# terraform.tfvars

region              = "us-east-1"                     # or your desired region
project_name        = "myproject"                     # your project name
vpc_cidr            = "10.0.0.0/16"                    # VPC CIDR block
availability_zones  = ["us-east-1a", "us-east-1b"]     # list of AZs for subnets
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]   # CIDRs for public subnets
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]  # CIDRs for private subnets

         # security group id for ALB (after creation, or leave blank if you create inside terraform)
