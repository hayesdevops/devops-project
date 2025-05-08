resource "aws_ecs_task_definition" "this" {
  family                   = "${var.environment}-task"
  network_mode             = var.network_mode
  requires_compatibilities = var.launch_type
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  container_definitions    = jsonencode(var.container_definitions)
  
  tags = local.common_tags
}