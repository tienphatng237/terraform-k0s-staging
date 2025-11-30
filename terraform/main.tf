provider "aws" {
  region = var.region
}

resource "aws_key_pair" "k0s_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

module "network" {
  source             = "./modules/network"
  name               = "k0s"
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  az                 = var.az
}

module "security" {
  source = "./modules/security"
  name   = "k0s"

  vpc_id              = module.network.vpc_id
  allowed_ssh_cidr    = var.allowed_ssh_cidr
  allowed_api_cidr    = var.allowed_api_cidr
  nodeport_cidr       = var.nodeport_cidr
  intra_node_cidr     = var.intra_node_cidr
  additional_tcp_ports = var.additional_tcp_ports
  additional_udp_ports = var.additional_udp_ports
}

module "compute" {
  source        = "./modules/compute"
  name          = "k0s"

  node_count    = var.node_count
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = module.network.public_subnet_id
  sg_id         = module.security.sg_id
  key_name      = aws_key_pair.k0s_key.key_name
}
