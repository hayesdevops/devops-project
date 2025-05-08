resource "aws_ecs_cluster" "this" {
  name = "${var.environment}-ecs-cluster"
  
  tags = local.common_tags
}