resource "ibm_compute_vm_instance" "vm1" {
hostname = "vm1"
domain = "example.com"
os_reference_code = "UBUNTU_18_64"
datacenter = "fra02"
network_speed = 10
hourly_billing = true
private_network_only = false
cores = 1
memory = 1024
disks = [25]
local_disk = false
ssh_key_ids = ["${ibm_compute_ssh_key.ssh_public_key_for_vm.id}"]
tags = ["group:webserver"]
}
