resource "aws_security_group" "k0s" {
  name   = "${var.name}-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr
  }

  ingress {
    description = "Kubernetes API"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = var.allowed_api_cidr
  }

  ingress {
    description = "NodePort"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = var.nodeport_cidr
  }

  ingress {
    description = "Internal TCP"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = var.intra_node_cidr
  }

  ingress {
    description = "Internal UDP"
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = var.intra_node_cidr
  }

  dynamic "ingress" {
    for_each = var.additional_tcp_ports
    content {
      description = "Additional TCP"
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "ingress" {
    for_each = var.additional_udp_ports
    content {
      description = "Additional UDP"
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.name}-sg" }
}
