####################
# ECR
####################
resource "aws_ecr_repository" "nginx_app_01" {
  name = "fargate-${var.project}-nginx-app-01"
}

resource "aws_ecr_repository" "php_app_01" {
  name = "fargate-${var.project}-php-app-01"
}

####################
# Cluster
####################
resource "aws_ecs_cluster" "cluster" {
  name = "cluster-fargate-${var.project}"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

####################
# Task Definition
####################
data "template_file" "task" {
  template = file("./task_definitions/task_definition.json")

  vars = {
    project = var.project
  }
}

resource "aws_ecs_task_definition" "task" {
  family                = "task-fargate-${var.project}-laravel"
  container_definitions = data.template_file.task.rendered
  cpu                   = "256"
  memory                = "512"
  network_mode          = "awsvpc"
  execution_role_arn    = aws_iam_role.fargate_task_execution.arn

  requires_compatibilities = [
    "FARGATE"
  ]
}

####################
# Service
####################
resource "aws_ecs_service" "service" {
  name            = "service-fargate-${var.project}"
  cluster         = aws_ecs_cluster.cluster.arn
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.alb.arn
    container_name   = "nginx"
    container_port   = "80"
  }

  network_configuration {
    subnets = [
      aws_subnet.dmz_1a.id,
      aws_subnet.dmz_1c.id
    ]
    security_groups = [
      aws_security_group.fargate.id
    ]
    assign_public_ip = false
  }
}
