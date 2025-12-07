# Output raw lists
output "public_ips" {
  value = module.compute.public_ips
}

output "private_ips" {
  value = module.compute.private_ips
}

# Output hosts.ini format cho Ansible
output "ansible_inventory" {
  value = <<-EOT
    [controller]
    controller-1 ansible_host=${module.compute.public_ips[0]} ansible_user=ubuntu private_ip=${module.compute.private_ips[0]}

    [workers]
    worker-1 ansible_host=${module.compute.public_ips[1]} ansible_user=ubuntu private_ip=${module.compute.private_ips[1]}
    worker-2 ansible_host=${module.compute.public_ips[2]} ansible_user=ubuntu private_ip=${module.compute.private_ips[2]}
    worker-3 ansible_host=${module.compute.public_ips[3]} ansible_user=ubuntu private_ip=${module.compute.private_ips[3]}

    [all:vars]
    ansible_ssh_private_key_file=../../key_pair/k0s_key
  EOT
}
