#########################################
#  ESXI Provider host/login details
#########################################
#
#   Use of variables here to hide/move the variables to a separate file
#
provider "esxi" {
  esxi_hostname = var.esxi_hostname
  esxi_hostport = var.esxi_hostport
  esxi_username = var.esxi_username
  esxi_password = var.esxi_password
}

#########################################
#  ESXI Guest Master
#########################################
  resource "esxi_guest" "master" {
  guest_name = "kube-master"
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
      mac_address     = "00:50:56:a1:b1:c0"
      nic_type        = "e1000"
    }

    connection {
      type     = "ssh"
      user     = "root"
      password = var.guest_password
      host     = "centos7-terraform-template"
    }

    provisioner "remote-exec" {
      inline = ["hostnamectl set-hostname kube-master","sleep 5","shutdown -r 5"]
   }

  guest_startup_timeout  = 45
  guest_shutdown_timeout = 30

}