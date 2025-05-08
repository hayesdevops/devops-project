

resource "aws_ec2_transit_gateway" "this" {
  count           = var.create_transit_gateway ? 1 : 0
  description     = "${var.environment} Transit Gateway"
  amazon_side_asn = var.amazon_side_asn
  tags = {
    Name = "${var.environment}-tgw"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  count              = local.tgw_id != "" ? 1 : 0
  transit_gateway_id = local.tgw_id
  vpc_id             = aws_vpc.this.id
  subnet_ids         = [aws_subnet.private.id]
  tags = {
    Name = "${var.environment}-tgw-attachment"
  }
}