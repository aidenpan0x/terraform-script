#resource "aws_subnet" "private-ap-northeast-1c" {
#  vpc_id            = aws_vpc.stable-eks.id
#  cidr_block        = "10.0.0.0/19"
#  availability_zone = "ap-northeast-1c"
#
#  tags = {
#    "Name"                                      = "private-ap-northeast-1c"
#    "kubernetes.io/role/internal-elb"           = "1"
#    "kubernetes.io/cluster/${var.eks_cluster_name}" = "owned"
#  }
#}

#resource "aws_subnet" "private-ap-northeast-1d" {
#  vpc_id            = aws_vpc.stable-eks.id
#  cidr_block        = "10.0.32.0/19"
#  availability_zone = "ap-northeast-1d"
#
#  tags = {
#    "Name"                                      = "private-ap-northeast-1d"
#    "kubernetes.io/role/internal-elb"           = "1"
#    "kubernetes.io/cluster/${var.eks_cluster_name}" = "owned"
#  }
#}

resource "aws_subnet" "public-ap-northeast-1c" {
  vpc_id                  = aws_vpc.stable-eks.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "public-ap-northeast-1c"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "owned"
  }
}

resource "aws_subnet" "public-ap-northeast-1d" {
  vpc_id                  = aws_vpc.stable-eks.id
  cidr_block              = "10.0.96.0/19"
  availability_zone       = "ap-northeast-1d"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "public-ap-northeast-1d"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "owned"
  }
}
