variable "name" {}
variable "vpc_id" {}

variable "allowed_ssh_cidr" { 
  type = list(string) 
  }
  
variable "allowed_api_cidr" { 
  type = list(string) 
  }

variable "nodeport_cidr" { 
  type = list(string) 
  }

variable "intra_node_cidr" { 
  type = list(string) 
  }

variable "additional_tcp_ports" {
  type = list(object({
    from = number
    to   = number
  }))

  default = []

}

variable "additional_udp_ports" {
  type = list(object({
    from = number
    to   = number
  }))

  default = []
  
}
