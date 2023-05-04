# ---------------------------
# VPC
# ---------------------------
resource "aws_vpc" "dev_vpc" {
  cidr_block = "10.0.0.0/16"
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
  vpc_id = aws_vpc.dev_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "${var.az_a}"

  tags = {
    Name = "terraform_public_dev_vpc_1a_sn"
  }
}

# ---------------------------
# Internet Gateway
# ---------------------------

resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name = "terraform_dev_igw"
  }
}

# ---------------------------
# Route table
# ---------------------------
resource "aws_route_table" "dev_public_rt" {
  vpc_id = aws
}
