#resource "aws_eip" "nat" {
#  vpc = true
#
#  tags = {
#    Name = "nat"
#  }
#}
#
#resource "aws_nat_gateway" "nat" {
#  allocation_id = aws_eip.nat.id
#  subnet_id     = var.subnets[0]
#
#  tags = {
#    Name = "nat"
#  }
#
#  depends_on = [aws_internet_gateway.igw]
#}
