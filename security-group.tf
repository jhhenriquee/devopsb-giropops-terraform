resource "aws_security_group" "main" {
  name        = "${var.project_name}-sg"
  description = "Security group para projeto ${var.project_name}"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Project   = var.project_name
    Terraform = "true"
  }
}

resource "aws_security_group_rule" "ingress" {
  for_each = var.allow_ingress

  type              = "ingress"
  from_port         = each.value.port
  to_port           = each.value.port
  protocol          = "tcp"
  cidr_blocks       = [each.value.cidr_block]
  description       = "Rule allow ${each.key}"
  security_group_id = aws_security_group.main.id
}

resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all outbound traffic"
  security_group_id = aws_security_group.main.id
}
