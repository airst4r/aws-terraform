resource "aws_subnet" "sstech_private" {
    count = "${var.subnets_count}"

    vpc_id = aws_vpc.sstech.id
    cidr_block = element(var.private_subnets.*.cidr_block, count.index)
    availability_zone = element(var.private_subnets.*.az, count.index)

    enable_resource_name_dns_a_record_on_launch = true
    map_public_ip_on_launch = false
    private_dns_hostname_type_on_launch = "ip-name"

    tags = {
        Name = "${var.VPC_NAME}-${element(var.private_subnets.*.name, count.index)}"
        "kubernetes.io/role/internal-elb" = 1
    }

}

resource "aws_subnet" "sstech_public" {
    count = var.subnets_count

    vpc_id = aws_vpc.sstech.id
    cidr_block = element(var.public_subnets.*.cidr_block, count.index)
    availability_zone = element(var.public_subnets.*.az, count.index)

    enable_resource_name_dns_a_record_on_launch = true
    map_public_ip_on_launch = true
    private_dns_hostname_type_on_launch = "ip-name"

    tags = {
        Name = "${var.VPC_NAME}-${element(var.public_subnets.*.name, count.index)}"
        "kubernetes.io/role/elb" = 1
    }

}

resource "aws_route_table" "sstech_rt_private" {
  vpc_id = aws_vpc.sstech.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.sstech_nat_gw.id
  }

  tags = {
    Name = "${var.VPC_NAME}-private-rt"
  }
}

resource "aws_route_table" "sstech_rt_public" {
  vpc_id = aws_vpc.sstech.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sstech_igw.id
  }

  tags = {
    Name = "${var.VPC_NAME}-public-rt"
  }
}

resource "aws_route_table_association" "sstech_rta_private" {
  count           = "${var.subnets_count}"
  subnet_id       = element(aws_subnet.sstech_private.*.id, count.index)
  route_table_id  = aws_route_table.sstech_rt_private.id
}

resource "aws_route_table_association" "sstech_rta_public" {
  count           = "${var.subnets_count}"
  subnet_id       = element(aws_subnet.sstech_public.*.id, count.index)
  route_table_id  = aws_route_table.sstech_rt_public.id
}

