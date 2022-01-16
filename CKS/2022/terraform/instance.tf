resource "aws_instance" "master" {
  count                  = 1
  ami                    = lookup(var.amis, var.aws_region)
  instance_type          = var.aws_instance_type
  key_name               = var.ssh_keypair
  user_data              = data.template_cloudinit_config.cloudinit-instance.rendered
  vpc_security_group_ids = [aws_security_group.cks-master.id]
  iam_instance_profile   = aws_iam_instance_profile.cks_profile.name
  subnet_id              = module.vpc.public_subnets[0]
}

resource "aws_instance" "node" {
  count                  = 2
  ami                    = lookup(var.amis, var.aws_region)
  instance_type          = var.aws_instance_type
  key_name               = var.ssh_keypair
  user_data              = data.template_cloudinit_config.cloudinit-instance.rendered
  vpc_security_group_ids = [aws_security_group.cks-node.id]
  iam_instance_profile   = aws_iam_instance_profile.cks_profile.name
  subnet_id              = module.vpc.public_subnets[0]
}
