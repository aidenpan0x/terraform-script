#resource "aws_route_table" "private" {
#  vpc_id = var.aws_vpc_stable-eks_id
#
#  route {
#    cidr_block     = "0.0.0.0/0"
#    nat_gateway_id = aws_nat_gateway.nat.id
#  }
#
#  tags = {
#    Name = "private"
#  }
#}
#
#resource "aws_route_table" "public" {
#  vpc_id = var.aws_vpc_stable-eks_id
#
#  route {
#    cidr_block = "0.0.0.0/0"
#    gateway_id = aws_internet_gateway.igw.id
#  }
#
#  tags = {
#    Name = "public"
#  }
#}
#
