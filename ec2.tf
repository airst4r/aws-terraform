
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] 
}

resource random_integer index {
    min = 1
    max = 999
}

locals {
    private_subnet_id_list = tolist(aws_subnet.sstech_private.*.id)
    private_subnet_id_random_index = random_integer.index.result % length(aws_subnet.sstech_private.*.id)
    private_instance_subnet_id = local.private_subnet_id_list[local.private_subnet_id_random_index]
}

resource "aws_instance" "sstech_rancher-instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  subnet_id = local.private_instance_subnet_id
  key_name = "${var.ssh_key_name}"
  vpc_security_group_ids = [aws_security_group.sstech_private-instance.id]

  root_block_device {

    volume_size = "50"
    volume_type = "gp3"

    tags = {
        Name = "rancher"
    }
  }

  lifecycle {
    ignore_changes = [
      ami,
    ]
  }

  tags = {
        Name = "rancher"
    }

}

resource "aws_instance" "sstech_gitlab-instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.large"
  subnet_id = local.private_instance_subnet_id
  key_name = "${var.ssh_key_name}"
  vpc_security_group_ids = [aws_security_group.sstech_private-instance.id]

  root_block_device {

    volume_size = "50"
    volume_type = "gp3"

    tags = {
        Name = "gitlab"
    }
  }

  lifecycle {
    ignore_changes = [
      ami,
    ]
  }

  tags = {
        Name = "gitlab"
    }

}

resource "aws_instance" "sstech_gitlab_runner-instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.small"
  subnet_id = local.private_instance_subnet_id
  key_name = "${var.ssh_key_name}"
  vpc_security_group_ids = [aws_security_group.sstech_private-instance.id]

  root_block_device {

    volume_size = "30"
    volume_type = "gp3"

    tags = {
        Name = "gitlab-runner"
    }
  }

  lifecycle {
    ignore_changes = [
      ami,
    ]
  }

  tags = {
        Name = "gitlab-runner"
    }

}


