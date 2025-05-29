module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${var.project_name}-sg"
  description = "Security group para projeto ${var.project_name}"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = 6
      description = "SSH Casa"
      cidr_blocks = join(",", var.allowed_cidrs)
    },
    {
      from_port   = 5000
      to_port     = 6000
      protocol    = 6
      description = "liberacao entre 5000 e 6000"
      cidr_blocks = join(",", var.allowed_cidrs)
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = 6
      description = "public HTTP"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = 6
      description = "public HTTPS"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "out free"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = {
    Project   = "${var.project_name}"
    Terraform = "true"
  }
}
