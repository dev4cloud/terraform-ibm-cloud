# Print IP address

output "ip_address" {
  value = "http://${ibm_compute_vm_instance.vm1.ipv4_address}:8080"
}
