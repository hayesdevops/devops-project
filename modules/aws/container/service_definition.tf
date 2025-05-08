resource "aws_ecs_service" "this" {
  name            = "${var.environment}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = var.service_launch_type

  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = var.assign_public_ip
  }
  
  tags = local.common_tags
}