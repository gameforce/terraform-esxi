#########################################
#  ESXI Guest Node
#########################################
  resource "esxi_guest" "default" {
  count = 3
  guest_name = "kube-node2"
  disk_store = "datastore-sata"
  guestos    = "centos-64"

  boot_disk_type = "thin"
  boot_disk_size = "35"

  memsize            = "2048"
  numvcpus           = "2"
  resource_pool_name = "/"
  power              = "on"

  clone_from_vm = "centos7"

    network_interfaces {
      virtual_network = "VM Network"
      mac_address     = "00:50:56:a1:b1:c2"
      nic_type        = "e1000"
    }

    connection {
      type     = "ssh"
      user     = "root"
      password = var.guest_password
      host     = "kube-node2"
    }

    provisioner "remote-exec" {
      inline = ["hostnamectl set-hostname kube-node2","sleep 10","shutdown -r"]
   }

  guest_startup_timeout  = 45
  guest_shutdown_timeout = 30
}