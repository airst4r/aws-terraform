resource "aws_vpc" "sstech" {
  cidr_block            = "${var.VPC_CIDR}"
  instance_tenancy      = "default"
  enable_dns_support    = true
  enable_dns_hostnames  = true

  tags = {
    Name = "${var.VPC_NAME}"
  }
}

resource "aws_internet_gateway" "sstech_igw" {
  vpc_id = aws_vpc.sstech.id

  tags = {
    Name = "${var.VPC_NAME}-igw"
  }
}

resource "aws_eip" "sstech_nat_eip" {
  depends_on = [aws_internet_gateway.sstech_igw]
  tags = {
    Name = "${var.VPC_NAME}-nat-gw"
  }
}

resource "aws_nat_gateway" "sstech_nat_gw" {
  allocation_id = aws_eip.sstech_nat_eip.id
  subnet_id     = element(aws_subnet.sstech_public.*.id, 0)
  depends_on    = [aws_internet_gateway.sstech_igw]
  
  tags = {
    Name        = "${var.VPC_NAME}-nat-gw"
  }
}

