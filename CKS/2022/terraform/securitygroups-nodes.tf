resource "aws_security_group" "cks-node" {
  name        = "terraform-k8s-cks-node"
  description = "Security group for all nodes in the cluster"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "terraform-k8s-cks-node"
  }
}

resource "aws_security_group_rule" "cks-node-ingress-self" {
  description       = "Allow node to communicate with each other"
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.cks-node.id
  to_port           = 65535
  type              = "ingress"
  self              = true
}

resource "aws_security_group_rule" "cks-node-ingress-cluster" {
  description       = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port         = 1025
  protocol          = "tcp"
  security_group_id = aws_security_group.cks-node.id
  to_port           = 65535
  type              = "ingress"
  self              = true
}

resource "aws_security_group_rule" "cks-node-ingress-node-ssh" {
  cidr_blocks       = ["${local.workstation-external-cidr}"]
  description       = "Allow workstation to communicate with node by SSH"
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.cks-node.id
  to_port           = 22
  type              = "ingress"
}
