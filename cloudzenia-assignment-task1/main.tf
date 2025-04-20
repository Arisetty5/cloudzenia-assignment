# --- VPC Module ---
module "vpc" {
  source              = "./modules/vpc"
  project_name        = var.project_name
  region              = var.region
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones  = var.availability_zones
}

# --- Security Group for RDS (needs VPC ID) ---
resource "aws_security_group" "rds" {
  name_prefix = "${var.project_name}-rds-sg-"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.ecs_service.id] # Allow traffic from ECS
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

# --- SecretsManager Module ---
module "secretsmanager" {
  source = "./modules/secretsmanager" # 
  project_name = var.project_name
  db_username  = var.db_username
  db_password  = var.db_password
  
}

# --- RDS Module ---
module "rds" {
  source            = "./modules/rds"
  project_name      = var.project_name
  private_subnet_ids = module.vpc.private_subnet_ids
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = module.secretsmanager.secret_value_json.password # Access password from secret
  db_security_group_ids = [aws_security_group.rds.id]
  tags              = var.tags
}

# --- Security Group for ALB (needs VPC ID) ---
resource "aws_security_group" "alb" {
  name_prefix = "${var.project_name}-alb-sg-"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

# --- Security Group for ECS Services (needs VPC & ALB SG ID) ---
resource "aws_security_group" "ecs_service" {
  name_prefix = "${var.project_name}-ecs-service-sg-"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb.id] # Allow traffic from the ALB
  }

  ingress {
    from_port   = 3000 # For your microservice
    to_port     = 3000
    protocol    = "tcp"
    security_groups = [aws_security_group.alb.id] # Allow traffic from the ALB
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

# --- ALB Module ---
module "alb" {
  source          = "./modules/alb"
  project_name    = var.project_name
  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnet_ids
  security_groups = [aws_security_group.alb.id]
  certificate_arn = var.certificate_arn
  tags            = var.tags
  name            = var.alb_name
  target_group_name = var.target_group_name
}

# --- ECS Module ---
module "ecs" {
  source                = "./modules/ecs"
  alb_wordpress_target_group_arn = module.alb.wordpress_tg_arn
  rds_endpoint = module.rds.rds_endpoint
  alb_microservice_target_group_arn = module.alb.microservice_tg_arn
  project_name          = var.project_name 
  secretsmanager_secret_arn = module.secretsmanager.secret_arn
  cluster_name = var.cluster_name
  wordpress_image       = var.wordpress_image
  microservice_image    = var.microservice_image
  private_subnets       = module.vpc.private_subnet_ids
  service_security_groups = [aws_security_group.ecs_service.id]
  db_name               = var.db_name
  tags                  = var.tags
  service_name          = var.service_name
  microservice_target_group_arn = module.alb.microservice_tg_arn
  
}


