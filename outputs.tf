# Print IP address

output "ip_address" {
  value = ["${ibm_compute_vm_instance.vm1.*.ipv4_address}"]
}

# virtual ip address of lbaas
output "vip" {
  value = "http://${ibm_lbaas.lbaas.vip}"
}
