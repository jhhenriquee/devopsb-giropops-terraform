resource "aws_key_pair" "key_pair" {
  count      = var.public_key != null ? 1 : 0
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
    values = [var.ubuntu_ami_name_filter]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_ebs_volume" "persist_data" {
  availability_zone = aws_instance.instance.availability_zone
  size              = var.ebs_volume_size

  tags = {
    Name      = "${var.project_name}-persist-data"
    Terraform = "true"
  }
}

resource "aws_instance" "instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.public_key != null ? "${var.project_name}-key" : null
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.main.id]

  user_data = file(var.user_data_file)

  tags = {
    Terraform = "true"
    Project   = var.project_name
  }
}

resource "aws_volume_attachment" "persist_data_attach" {
  device_name  = "/dev/${var.ebs_device_name}"
  volume_id    = aws_ebs_volume.persist_data.id
  instance_id  = aws_instance.instance.id
  force_detach = true
}