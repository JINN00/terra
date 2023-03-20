terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "2.9.14"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://test.co.kr:8006/api2/json"
  pm_debug = true
}

resource "proxmox_vm_qemu" "proxmox_vm" {
  for_each    = var.vm-settings

  vmid        = each.key
  name        = each.value.vmname
  target_node = "test"
 
  clone = "centos7-template"
  full_clone = "false"

  cpu     = "kvm64"
  cores   = each.value.cores
  sockets = 1
  memory  = each.value.memory
	
  scsihw  = "virtio-scsi-single"
  boot    = "order=scsi0"

  disk {
    storage = "btc-128k"
    type  = "scsi"
    size  = each.value.disk0size
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  network {
    model  = "virtio"
    bridge = "vmbr3"
  }

  ssh_user        = "root"
  sshkeys = file("${path.module}/id_rsa.pub")

  os_type   = "cloud-init"

  ipconfig0 = "ip=${each.value.cidr0},gw=${var.gateway0}"
  ipconfig1 = var.gateway1 == null ? "ip=${each.value.cidr1}" : "ip=${each.value.cidr1},gw=${var.gateway1}"
}
