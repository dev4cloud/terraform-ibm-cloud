resource "ibm_compute_vm_instance" "vm1" {
  count = "2"
  hostname = "vm1-${format("%02d", count.index + 1)}"
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

resource "random_id" "lbass_id" {
  byte_length = 8
}

resource "ibm_lbaas" "lbaas" {
  name        = "myloadbalancer-${random_id.lbass_id.hex}"
  description = "lbaas example"
  subnets     = ["${ibm_compute_vm_instance.vm1.*.private_subnet_id[0]}"]

  protocols = [
    {
      frontend_protocol     = "HTTP"
      frontend_port         = 80
      backend_protocol      = "HTTP"
      backend_port          = 8080
      load_balancing_method = "round_robin"
      session_stickiness    = "SOURCE_IP"
    }
  ]
}

resource "ibm_lbaas_server_instance_attachment" "lbaas_member" {
  count = 2
  private_ip_address = "${element(ibm_compute_vm_instance.vm1.*.ipv4_address_private,count.index)}"
  weight             = 40
  lbaas_id           = "${ibm_lbaas.lbaas.id}"
}

resource "ibm_lbaas_health_monitor" "lbaas_hm" {
  protocol = "${ibm_lbaas.lbaas.health_monitors.0.protocol}"
  port = "${ibm_lbaas.lbaas.health_monitors.0.port}"
  timeout = 3
  lbaas_id = "${ibm_lbaas.lbaas.id}"
  monitor_id = "${ibm_lbaas.lbaas.health_monitors.0.monitor_id}"
}
