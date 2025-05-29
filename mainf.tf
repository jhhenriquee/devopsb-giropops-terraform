resource "aws_key_pair" "key_pair" {
  key_name   = "${var.project_name}-key"
  public_key = var.public_key
  tags = {
    Terraform = "true"
    Project   = var.project_name
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = "${var.project_name}-key"
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.security_group.security_group_id]

  user_data = file(var.user_data_file)

  tags = {
    Terraform = "true"
    Project   = var.project_name
  }
}


