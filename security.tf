resource "ibm_compute_ssh_key" "ssh_public_key_for_vm" {
 label = "mysshkey"
 notes = "my generated ssh key"
 public_key = "<PUT YOUR KEY HERE>"
}

resource "random_id" "sg_id" {
  byte_length = 8
}

resource "ibm_security_group" "sg1_public" {
    name = "sg1-${random_id.sg_id.hex}"
    description = "allow ssh and http traffic"
}

resource "ibm_security_group_rule" "ssh" {
  direction         = "ingress"
  ether_type        = "IPv4"
  port_range_min    = 22
  port_range_max    = 22
  protocol          = "tcp"
  security_group_id = "${ibm_security_group.sg1_public.id}"
}

resource "ibm_security_group_rule" "http_special" {
  direction         = "ingress"
  ether_type        = "IPv4"
  port_range_min    = 8080
  port_range_max    = 8080
  protocol          = "tcp"
  security_group_id = "${ibm_security_group.sg1_public.id}"
}

resource "ibm_security_group_rule" "http" {
  direction         = "ingress"
  ether_type        = "IPv4"
  port_range_min    = 80
  port_range_max    = 80
  protocol          = "tcp"
  security_group_id = "${ibm_security_group.sg1_public.id}"
}

resource "ibm_security_group_rule" "https_outbound" {
  direction         = "egress"
  ether_type        = "IPv4"
  port_range_min    = 443
  port_range_max    = 443
  protocol          = "tcp"
  security_group_id = "${ibm_security_group.sg1_public.id}"
}
