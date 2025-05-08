resource "aws_security_group" "private" {
  name        = "${var.environment}-private-sg"
  description = "Security group for private resources"
  vpc_id      = aws_vpc.this.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${var.environment}-private-sg"
  })

  lifecycle {
    create_before_destroy = true
  }
}
