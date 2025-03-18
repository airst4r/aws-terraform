resource "aws_ec2_client_vpn_endpoint" "sstech_cvpn" {
  description             = "sstech-cvpn"
  vpc_id                  = aws_vpc.sstech.id
  security_group_ids      = [aws_security_group.sstech_openvpn.id]

  server_certificate_arn  = "${var.aws_acm_certificate_server_arn}"
  client_cidr_block       = "${var.vpn_client_cidr}"

  split_tunnel            = true
  transport_protocol      = "udp"
  vpn_port                = "443"

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = "${var.aws_acm_certificate_client_arn}"
  }

  connection_log_options {
    enabled = false
  }

  tags = {
    Name = "${var.VPC_NAME}-cvpn"
  }

}

resource "random_shuffle" "subnet_for_vpn_assoc" {
  input         = aws_subnet.sstech_private.*.id
  result_count  = 1
}

resource "aws_ec2_client_vpn_network_association" "sstech_cvna_cvpn" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.sstech_cvpn.id
  subnet_id              = "${random_shuffle.subnet_for_vpn_assoc.result[0]}"
}

resource "aws_ec2_client_vpn_authorization_rule" "sstech_cvar_cvpn" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.sstech_cvpn.id
  target_network_cidr    = "0.0.0.0/0"
  authorize_all_groups   = true
}

