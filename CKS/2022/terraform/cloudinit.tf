data "template_file" "instance-init" {
  template = "${file("scripts/instance-init.sh")}"
}

data "template_cloudinit_config" "cloudinit-instance" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.instance-init.rendered}"
  }
}