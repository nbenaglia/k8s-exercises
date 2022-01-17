output "master" {
  value = aws_instance.master.*.public_ip
}

output "node" {
  value = aws_instance.node.*.public_ip
}
