variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "project_name" {
  description = "name of the project"
  type        = string
}

variable "public_key" {
  type        = string
  description = "Public SSH key"
}
#"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCxlKx6EtgBAnjIAc33QIZhPKY87yTLTqLw89tQrZgyVr6BOvFmE33kgOVX1rTyPIXot+D+mF5uqNL0DTSlmz2DJi/2q/Z8fV9gNNTgoPXTQGDakvP+Y9jYhEEUAf/PyKJ7e2otCobP9RvNiyFENLo66pW0vwAO6xmqiRe18r6ImUFvt2CfoulGttYspSNx1iuqYbaR8XHkXBma5Vvl3l+/PrdhkqE5wcfFe2KP42O8ew7xf4HMRWyGekozjm4i/dP5Uk3asKWpf0pBGLDPcm8qVMWwCkIsNZSpdWU8u7Rt0KCbcH1VxqSJlfEORh95j0OqVKkFbpEZ8qjjrJE6nQCh58YJOysLWf0DcDJhZQJzqsL5EtiBeGuBVx1LvszWJs224QgfuWXRwuR8OJdL8KjPY0vYVFIaxDQ50pZ8r2WcjGhbbUBc2qagQJUeIov6h9ncQxmpXT7tmY82FxvCIOY17ibRgjFMLmmDaFjOYKx5tvNHQojgoN1bJ6UQ5QUCzzM= sky\\jose.silva@sky01009-nb"

variable "allowed_cidrs" {
  type        = list(string)
  description = "Lista de CIDRs autorizados para SSH e portas entre 5000 e 6000"
  default     = ["0.0.0.0/0"]
}

variable "user_data_file" {
  description = "Caminho para o script de inicialização (user data)"
  type        = string
}

variable "ubuntu_ami_name_filter" {
  type        = string
  description = "Filtro para o nome da AMI Ubuntu, com wildcards"
  default     = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
}