variable "VPC_CIDR" {
    description = "VPC CIDR for AWS"
    #default = "10.11.0.0/16"
    type = string
}

variable "VPC_NAME" {
    description = "VPC name for AWS "
    default = "default_vpc"
    type = string
}

variable "subnets_count" {
    type = number
}

variable "public_subnets" {
    description = "public subnets"
    type = list
    default = []

}

variable "private_subnets" {
    description = "private subnets"
    type = list
    default = []
}

variable "ssh_key_name" {
    type = string
    default = "sergesrj"

}

variable "eks_cluster_create" {    
    default = "false"
    type    = bool
}

variable "eks_cluster_name" {    
    default = "sstech-cluster"
    type    = string
}

variable "eks_cluster_version" {    
    default = "1.31"
    type    = string
}


variable "aws_acm_certificate_server_arn" {    
    default = "aws_acm_certificate_server_arn"
    type    = string
}

variable "aws_acm_certificate_client_arn" {    
    default = "aws_acm_certificate_client_arn"
    type    = string
}

variable "vpn_client_cidr" {    
    default = "vpn_client_cidr"
    type    = string
}