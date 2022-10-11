####################
# Security Group
####################
resource "aws_security_group" "alb" {
  name        = "alb-${var.project}-sg"
  description = "for ALB"
  vpc_id      = aws_vpc.vpc.id
}

resource "aws_security_group" "fargate" {
  name        = "fargate-${var.project}-sg"
  description = "for Fargate"
  vpc_id      = aws_vpc.vpc.id
}

#####################
# Security Group Rule
#####################
resource "aws_security_group_rule" "allow_http_for_alb" {
  security_group_id = aws_security_group.alb.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "allow_http_for_alb"
}

resource "aws_security_group_rule" "from_alb_to_fargate" {
  security_group_id        = aws_security_group.fargate.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
  source_security_group_id = aws_security_group.alb.id
  description              = "from_alb_to_fargate"
}

resource "aws_security_group_rule" "egress_alb" {
  security_group_id = aws_security_group.alb.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Outbound ALL"
}

resource "aws_security_group_rule" "egress_fargate" {
  security_group_id = aws_security_group.fargate.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Outbound ALL"
}
