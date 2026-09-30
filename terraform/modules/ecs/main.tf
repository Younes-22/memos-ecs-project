resource "aws_security_group" "ecs_tasks" {
    name = "ecs-task-sg"
    description = "ecs tasks security group"
    vpc_id = var.vpc_id

    ingress {
        description = "Allow traffic from ALB"
        from_port = 8081
        to_port = 8081
        protocol = "tcp"
        security_groups = [var.alb_security_group_id]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "ecs-task-sg"
    }
}

resource "aws_ecs_cluster" "this" {
  name = "ecs-cluster"

  tags = {
    Name = "ecs-cluster"
  }
}

resource "aws_ecs_task_definition" "this" {
    family = "service"
    requires_compatibilities = ["FARGATE"]
    cpu = "256"
    memory = "512"
    network_mode = "awsvpc"
    execution_role_arn = var.execution_role_arn

    runtime_platform {
        operating_system_family = "LINUX"
        cpu_architecture = "X86_64"
  }
  container_definitions = jsonencode([
    {
      name      = "memos" // needs to match service name
      image     = var.container_image
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 8081
          hostPort      = 8081
        }
      ]
    }
  ])

#   volume {
#     name      = "service-storage"
#     host_path = "/ecs/service-storage"
#   }

#   placement_constraints {
#     type       = "memberOf"
#     expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
#   }
}


// ecs service
resource "aws_ecs_service" "memos" {
  name = "memos-service"
  cluster = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count = 1
  launch_type = "FARGATE"

  network_configuration {
    subnets = [
      var.private_subnet_1_id,
      var.private_subnet_2_id
    ]

    security_groups = [aws_security_group.ecs_tasks.id]

    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name = "memos"
    container_port = 8081
  }
}
