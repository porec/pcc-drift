# Simple instance template

provider "aws" {
  region = "eu-north-1"
}

resource "aws_security_group" "dima-SG" {
  name = "dima-ssh_traffic"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    git_commit           = "c3ac37102bc317699e966bfdb3b33c747a284d01"
    git_file             = "ec2-ubuntu.tf"
    git_last_modified_at = "2022-07-18 07:10:37"
    git_last_modified_by = "32958664+dreshytnik@users.noreply.github.com"
    git_modifiers        = "32958664+dreshytnik"
    git_org              = "porec"
    git_repo             = "pcc-drift"
    yor_trace            = "f7ad4963-1460-4a69-8bac-436ed0d0d921"
  }
  ingress {
    to_port = 443
    protocol = "tcp"
    from_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = "vpc-db861ab1"
}


resource "aws_instance" "dima-EC2" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.dima-SG.name}"]
  key_name        = "linux-key-pair"
  tags = {
    git_commit           = "c3ac37102bc317699e966bfdb3b33c747a284d01"
    git_file             = "ec2-ubuntu.tf"
    git_last_modified_at = "2022-07-18 07:10:37"
    git_last_modified_by = "32958664+dreshytnik@users.noreply.github.com"
    git_modifiers        = "32958664+dreshytnik"
    git_org              = "porec"
    git_repo             = "pcc-drift"
    yor_trace            = "d75fff88-ece5-4107-81eb-a23de5245fb5"
  }
  monitoring = true
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
