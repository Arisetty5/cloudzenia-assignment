# Declare the VPC module
module "vpc" {
  source  = "../cloudzenia-assignment-task1/modules/vpc" #  Corrected source path
  project_name  = var.project_name
  region          = var.region # Make sure this variable is defined
  vpc_cidr      = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs # Make sure this variable is defined
  private_subnet_cidrs = var.private_subnet_cidrs # Make sure this variable is defined
  availability_zones  = var.availability_zones # Make sure this variable is defined
}

# Declare the EC2 instances module
module "ec2_instances" {
  source  = "./modules/ec2" # Corrected source path
  ami_id  = "ami-084568db4383264d4" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  private_subnet_id = module.vpc.private_subnet_ids[0] #  Use output from VPC module
  key_name  = "nginx" #  Make sure this variable is defined
  project_name = "cloudzenia"
  security_group_ids = [module.security.ec2_security_group_id] # Use output from security module
  target_group_arn = module.alb.target_group_arn # Use output from alb module
}

# Declare the security module
module "security" {
  source  = "./modules/security" # Corrected source path
  vpc_id  = module.vpc.vpc_id #  Use output from VPC module
  project_name = "cloudzenia-task2"
}

# Declare the ALB module
module "alb" {
  source  = "./modules/alb" # Corrected source path
  alb_name  = "cloudzenia-task2-alb"
  security_group_id = module.security.alb_security_group_id #  Ensure this is defined.  It might need to come from the security module.
  subnet_ids  = module.vpc.public_subnet_ids #  Use output from VPC module
  target_group_name = "cloudzenia-task2-tg"
  target_group_port = 80
  vpc_id  = module.vpc.vpc_id #  Use output from VPC module
}
