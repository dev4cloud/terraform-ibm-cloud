resource "ibm_compute_ssh_key" "ssh_public_key_for_vm" {
 label = "mysshkey"
 notes = "my generated ssh key"
 public_key = "KEY"
}
