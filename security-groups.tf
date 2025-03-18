resource "aws_security_group" "sstech_openvpn" {
  name        = "sstech_openvpn"
  description = "openvpn security group for sergesrjedu.tech"
  vpc_id      = aws_vpc.sstech.id

  tags = {
    Name = "${var.VPC_NAME}-cvpn-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_ingress_traffic_ipv4" {
  security_group_id = aws_security_group.sstech_openvpn.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_egress_traffic_ipv4" {
  security_group_id = aws_security_group.sstech_openvpn.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_security_group" "sstech_private-instance" {
  name        = "all-traffic-within-vpc"
  description = "all-traffic-within-vpc for sergesrjedu.tech"
  vpc_id      = aws_vpc.sstech.id

  tags = {
    Name = "${var.VPC_NAME}-all-traffic-within-vpc"
  }
}

resource "aws_vpc_security_group_ingress_rule" "private_instance_allow_all_ipv4" {
  security_group_id = aws_security_group.sstech_private-instance.id
  cidr_ipv4         = "${var.VPC_CIDR}"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "private_instance_allow_all_egress_ipv4" {
  security_group_id = aws_security_group.sstech_private-instance.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
