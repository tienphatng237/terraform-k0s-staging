variable "region" {}
variable "key_name" {}
variable "public_key_path" {}

variable "vpc_cidr" {}
variable "public_subnet_cidr" {}
variable "az" {}

variable "allowed_ssh_cidr" { type = list(string) }
variable "allowed_api_cidr" { type = list(string) }
variable "nodeport_cidr" { type = list(string) }
variable "intra_node_cidr" { type = list(string) }

variable "additional_tcp_ports" {
  type = list(object({
    from = number
    to   = number
  }))
}

variable "additional_udp_ports" {
  type = list(object({
    from = number
    to   = number
  }))
}

variable "node_count" { type = number }
variable "ami" {}
variable "instance_type" {}
