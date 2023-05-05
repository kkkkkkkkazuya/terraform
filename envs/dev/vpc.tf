# ---------------------------
# VPC
# ---------------------------
resource "aws_vpc" "dev_vpc" {
  cidr_block = var.vpc_cider
  # DNSホスト名有効化
  enable_dns_hostnames = true
  tags = {
    Name = "new-dev-vpc"
  }
}

# ---------------------------
# サブネット
# ---------------------------
resource "aws_subnet" "public_dev_vpc_1a_sn" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.public_dev_cidr_block
  availability_zone = var.az_a

  tags = {
    Name = "terraform-public-dev-vpc-1a-sn"
  }
}

# ---------------------------
# Internet Gateway
# ---------------------------

resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name = "terraform-dev-igw"
  }
}

# ---------------------------
# Route table
# ---------------------------
resource "aws_route_table" "dev_public_rt" {
  vpc_id = aws_vpc.dev_vpc.id
  route {
    cidr_block = dev_all_rt_cidr_block
    gateway_id = aws_internet_gateway.dev_igw.id
  }
  tags = {
    Name = "terraform-dev-public-rt"
  }
}

# SubnetとRoute tableの関連付け
resource "aws_route_table_association" "dev_public_rt_associate" {
  subnet_id      = aws_subnet.public_dev_vpc_1a_sn.id
  route_table_id = aws_route_table.dev_public_rt.id
}

# ---------------------------
# Security Group
# ---------------------------
resource "aws_security_group" "dev_public_sg" {
  name        = "terraform-dev-public-sg"
  description = "For ALB"
  vpc_id      = aws_vpc.dev_vpc.id
  tags = {
    Name = "terraform-dev-public-sg"
  }

  # インバウンドルール
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "http"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress = {
    from_port   = 443
    to_port     = 443
    protocol    = "https"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # アウトバウンドルール
  egress = {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
  cidr_blocks = ["0.0.0.0/0"] }
}