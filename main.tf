terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
}

provider "proxmox" {
  pm_api_url      = var.pm_api_url
  pm_user         = var.pm_user
  pm_password     = var.pm_password
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "ubuntu_vm" {
  for_each    = {for c in var.containers : c.name => c}
  name        = each.value.name
  target_node = each.value.target_node
  vmid        = each.value.vmid
  clone       = "template"
  full_clone  = true

  cores   = each.value.cores
  memory  = each.value.memory
  balloon = each.value.balloon
  sockets = 1

  bios     = "ovmf"
  machine  = "virt"
  boot     = "order=scsi0"
  bootdisk = "scsi0"
  scsihw   = "virtio-scsi-pci"
  agent    = 1

  serial {
    id   = 0
    type = "socket"
  }

  disk {
    type    = "disk"
    storage = "host_vm"
    size    = "32G"
    slot    = "scsi0"
  }

  disk {
    type    = "cloudinit"
    storage = "core_data"
    slot    = "scsi1"
  }

  network {
    model   = "virtio"
    bridge  = "vmbr0"
    id      = 0
    macaddr = each.value.mac
  }

  ciuser     = var.ci_user
  cipassword = var.ci_password_hashed
  sshkeys    = file(var.path_ssh_key)
  ipconfig0  = "ip=${each.value.ip_address},gw=192.168.0.1"
}