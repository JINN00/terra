terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "2.9.14"
    }
  }
}

provider "proxmox" {
  pm_debug = true
}

resource "proxmox_vm_qemu" "proxmox_vm" {
  for_each    = var.vm-settings

  vmid        = each.key
  name        = each.value.vmname
  target_node = var.target-node
 
  clone = "centos7-template"
  full_clone = "true"

  cpu     = "kvm64"
  cores   = each.value.cores
  sockets = 1
  memory  = each.value.memory
	
  scsihw  = "virtio-scsi-single"
  boot    = "order=scsi0"

  disk {
    storage = var.storage
    type  = "scsi"
    file  = "vm-${each.key}-disk-0"
    size  = each.value.disk0size
    volume = "${var.storage}:vm-${each.key}-disk-0" 
  }

  network {
    model  = "virtio"
    bridge = var.bridge0
  }

  network {
    model  = "virtio"
    bridge = var.bridge1
  }

  os_type   = "cloud-init"
  ssh_user        = "root"
  sshkeys = file("${path.module}/id_rsa.pub")
  ipconfig0 = "ip=${each.value.cidr0},gw=${var.gateway0}"
  ipconfig1 = var.gateway1 == null ? "ip=${each.value.cidr1}" : "ip=${each.value.cidr1},gw=${var.gateway1}"
  nameserver = var.dns-server
}
