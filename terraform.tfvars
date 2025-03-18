VPC_CIDR = "10.20.0.0/16"
VPC_NAME = "sstech_vpc"

subnets_count = 2

private_subnets = [
    {
        cidr_block = "10.20.1.0/24"
        name = "sstech_private_a"
        az = "eu-central-1a"
    },
    {
        cidr_block = "10.20.3.0/24"
        name = "sstech_private_b"
        az = "eu-central-1b"
    },
    {
        cidr_block = "10.20.5.0/24"
        name = "sstech_private_c"
        az = "eu-central-1c"
    }

]

public_subnets = [
{
        cidr_block = "10.20.2.0/24"
        name = "sstech_public_a"
        az = "eu-central-1a"
    },
    {
        cidr_block = "10.20.4.0/24"
        name = "sstech_public_b"
        az = "eu-central-1b"
    },
    {
        cidr_block = "10.20.6.0/24"
        name = "sstech_public_c"
        az = "eu-central-1c"
    }

]

ssh_key_name = "sergesrj"

eks_cluster_create = true

vpn_client_cidr = "10.99.0.0/22"
aws_acm_certificate_server_arn = "arn:aws:acm:eu-central-1:339713032208:certificate/df360ddf-6f29-472c-b6bb-2e723777a55a"
aws_acm_certificate_client_arn = "arn:aws:acm:eu-central-1:339713032208:certificate/42dce81d-93fe-4b4d-ab50-0b5ca709b9fb"