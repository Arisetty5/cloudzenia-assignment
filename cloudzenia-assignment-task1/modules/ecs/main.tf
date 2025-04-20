resource "aws_ecs_cluster" "wordpress-node-cluster" {
  name = var.cluster_name
}

resource "aws_iam_role" "task_execution_role" {
  name = "${var.project_name}-ecs-task-execution-role"

  assume_role_policy = jsonencode({ # Use jsonencode to convert to a JSON string
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "task_execution_attachment" {
  role = aws_iam_role.task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# WordPress Task Definition

resource "aws_ecs_task_definition" "wordpress" {
  family = "${var.project_name}-wordpress"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = "512"
  memory = "1024"
  execution_role_arn = aws_iam_role.task_execution_role.arn

  container_definitions = jsonencode([
    {
        name = "wordpress"
        image = var.wordpress_image

        portMappings = [{
            containerPort = 80
            protocol = "TCP"
        }]

        secrets = [{

          name = "WORDPRESS_DB_USER"
          valueFrom = var.secretsmanager_secret_arn
        },

        {
          name = "WORDPRESS_DB_PASSWORD"
          valueFrom = var.secretsmanager_secret_arn
        }
        ]

        environment = [{
          name = "WORDPRESS_DB_HOST"
          value = var.rds_endpoint

        },
        {
          name = "WORDPRESS_DB_NAME"
          value = var.db_name
        }
          
        
        ]
    }
  ])
}

# WordPress Service

resource "aws_ecs_service" "wordpress_service" {
  name = "${var.project_name}-wordpress-service"
  cluster = aws_ecs_cluster.wordpress-node-cluster.id
  task_definition = aws_ecs_task_definition.wordpress.arn
  desired_count = 1
  launch_type = "FARGATE"

  network_configuration {
    subnets = var.private_subnets
    assign_public_ip = false
    security_groups = var.service_security_groups
  }

  load_balancer {
  target_group_arn = var.alb_wordpress_target_group_arn
  container_name   = "wordpress"
  container_port   = 80
  }

  lifecycle {
    create_before_destroy = true
  }
  
}

# Node.js Microservice Task Definition

resource "aws_ecs_task_definition" "microservice" {
  family                   = "${var.project_name}-microservice"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "microservice"
      image     = var.microservice_image
      portMappings = [{
        containerPort = 80
        protocol      = "tcp"
      }]
      environment = [
        {
          name  = "MESSAGE"
          value = "Hello from Microservice"
        }
      ]
    }
  ])
}

# Node.js Microservice Service

resource "aws_ecs_service" "microservice_service" {
  name            = "${var.project_name}-microservice-service"
  cluster         = aws_ecs_cluster.wordpress-node-cluster.id
  task_definition = aws_ecs_task_definition.microservice.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.private_subnets
    assign_public_ip = false
    security_groups  = var.service_security_groups
  }

  load_balancer {
    target_group_arn = var.alb_microservice_target_group_arn
    container_name   = "microservice"
    container_port   = 80 # Or your microservice port
  }
}





