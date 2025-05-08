resource "aws_eip" "vpn_endpoint" {
  count = var.create_vpn_endpoint ? 1 : 0
  vpc   = true
  tags = {
    Name = "${var.environment}-vpn-endpoint"
  }
}