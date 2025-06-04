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
  default     = null
}

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

variable "allow_ingress" {
  type = map(object({
    port       = number
    cidr_block = string
  }))
  default = {
    http = {
      port       = 80
      cidr_block = "0.0.0.0/0"
    },
    https = {
      port       = 443
      cidr_block = "0.0.0.0/0"
    }
  }
}

variable "ebs_volume_size" {
  description = "Tamanho do volume EBS (em GB) usado para persistência de dados"
  type        = number
  default     = 0
}

variable "ebs_device_name" {
  description = "Tamanho do volume EBS (em GB) usado para persistência de dados"
  type        = string
  default     = "xvdf"
}
