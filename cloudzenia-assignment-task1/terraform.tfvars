region = "us-east-1"
project_name = "cloudzenia"
vpc_cidr = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones = ["us-east-1a", "us-east-1b"]
microservice_image = "arisetty5/cloudzenia-microservice:v1"
db_name     = "wordpressdb"
db_username = "adminuser"
cluster_name = "cloudzenia-ecs-cluster"
service_name = "cloudZenia-wordpress-service"
certificate_arn = "dummy-certificate-arn"

alb_name               = "cloudzenia-alb"
db_security_group_ids  = []
name                   = "cloudzenia-ecs-task"
private_subnet_ids     = []
secretsmanager_secret_arn = "dummy-secret-arn"
target_group_name      = "cloudzenia-wordpress-tg"
wordpress_image        = "wordpress:latest"


tags = {
  Environment = "test"
  Owner       = "Bhargav Sai"
}
