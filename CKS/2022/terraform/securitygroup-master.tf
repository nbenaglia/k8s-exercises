resource "aws_security_group" "cks-master" {
  name        = "terraform-k8s-cks-master"
  description = "Cluster communication with worker nodes"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-k8s-cks-master"
  }
}

resource "aws_security_group_rule" "cks-master-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.cks-master.id
  source_security_group_id = aws_security_group.cks-node.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "cks-master-ingress-workstation-https" {
  cidr_blocks       = ["${local.workstation-external-cidr}"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.cks-master.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "cks-master-ingress-node-ssh" {
  cidr_blocks       = ["${local.workstation-external-cidr}"]
  description       = "Allow workstation to communicate with node by SSH"
  from_port         = 0
  protocol          = "tcp"
  security_group_id = aws_security_group.cks-master.id
  to_port           = 22
  type              = "ingress"
}
