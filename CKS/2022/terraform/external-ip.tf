data "http" "workstation-external-ip" {
  url = "https://ifconfig.co/ip"
}

locals {
  workstation-external-cidr = "${chomp(data.http.workstation-external-ip.body)}/32"
}