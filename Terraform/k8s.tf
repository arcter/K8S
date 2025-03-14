locals {
  k8s = {
    master-01 = {
      number = 10
      cores  = 10
      memory = 10240
    }
    worker-01 = {
      number = 11
      cores  = 10
      memory = 10240
    }
    worker-02 = {
      number = 12
      cores  = 10
      memory = 10240
    }
  }
  support ={
    nfs = {
      number = 1
      cores  = 4
      memory = 4096
      type = "SSH"
      size= "200G"
    }
  }

}

resource "proxmox_vm_qemu" "vm" {
  for_each = { for k, v in local.k8s : k => v }

  name = each.key
  desc = "Kubernetes"
  vmid = "9${each.value.number}"

  target_node = "rimuru"

  clone = "debian-template"

  agent = 1

  cores   = each.value.cores
  sockets = 1
  vcpus   = 0
  memory  = each.value.memory

  os_type = "cloud-init"
  disks {
    size    = "32G"
    type    = "virtio"
    storage = "SSH"
  }
  # disks {
  #   size    = "100G"
  #   type    = "virtio"
  #   storage = "telnet"
  # }

  network {
    model   = "virtio"
    bridge  = "k8s"
    macaddr = "7A:19:32:CF:F4:${each.value.number}"
  }

  nameserver = "1.1.1.1"
  ipconfig0  = "ip=192.168.254.${each.value.number}/24,gw=192.168.254.254"
  sshkeys    = <<-EOT
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDb+hKr3tBd+nvzbWgtd8FDMyJRQgdb15sjJXI+id68C/WfttYQ+2544XXt/pZIzZfgXx6OHjL4c9Wg817CayY1qLV1R2Uk6/2ieMYLDafDy+T2nvOiWIIJ9cJFj99l+sxXO0ILEdrrMrv8tzibTaActIa4wj+l7zg2qKKwPPzUTxBHz292pLpN60IAUVoAugNX0iS83CHC310wccWOMV2U5jw9cW7yyq+alykQ6Suk+bvW88S+zfcuRVoGDCQpYNl7K9i559lmfRllopS+RViczSAqKHGg//8UhFH/740ywY7zbejZKqj1M6LrIkwlNH8rHuwe3hclMwaNpYf3VcXOvmOJu7dbLseAxb5vWnxrNIt2iDqJ15RfTmEDVUaLax+KzS8DnuZ7YGUWs8rECbxsjdF698aGwLen7I9gube7rB4AHi/YVotbwTVVfD7dy2BPvL4ycTNp8g3yngN5QLkKmH4TL8uCXTofO4RinicJrMWbR2OHuO3lMuaNqwLmqF0= arcter@fedora
EOT
}

# resource "proxmox_vm_qemu" "vm2" {
#   for_each = { for k, v in local.support : k => v }

#   name = each.key
#   desc = "support infra for k8s"
#   vmid = "100${each.value.number}"

#   target_node = "tempest"

#   clone = "ubuntu-cloudinit-20.04"

#   agent = 1

#   cores   = each.value.cores
#   sockets = 1
#   vcpus   = 0
#   memory  = each.value.memory

#   os_type = "cloud-init"
#   disks {
#     size    = each.value.size
#     type    = "virtio"
#     storage = each.value.type
#   }
#   # disks {
#   #   size    = "100G"
#   #   type    = "virtio"
#   #   storage = "telnet"
#   # }

#   network {
#     model   = "virtio"
#     bridge  = "vmbr4"
#     macaddr = "7A:19:32:CF:F5:0${each.value.number}"
#   }

#   nameserver = "192.168.255.254"
#   ipconfig0  = "ip=192.168.253.${each.value.number}/24,gw=192.168.253.254"
#   sshkeys    = <<-EOT
# ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDb+hKr3tBd+nvzbWgtd8FDMyJRQgdb15sjJXI+id68C/WfttYQ+2544XXt/pZIzZfgXx6OHjL4c9Wg817CayY1qLV1R2Uk6/2ieMYLDafDy+T2nvOiWIIJ9cJFj99l+sxXO0ILEdrrMrv8tzibTaActIa4wj+l7zg2qKKwPPzUTxBHz292pLpN60IAUVoAugNX0iS83CHC310wccWOMV2U5jw9cW7yyq+alykQ6Suk+bvW88S+zfcuRVoGDCQpYNl7K9i559lmfRllopS+RViczSAqKHGg//8UhFH/740ywY7zbejZKqj1M6LrIkwlNH8rHuwe3hclMwaNpYf3VcXOvmOJu7dbLseAxb5vWnxrNIt2iDqJ15RfTmEDVUaLax+KzS8DnuZ7YGUWs8rECbxsjdF698aGwLen7I9gube7rB4AHi/YVotbwTVVfD7dy2BPvL4ycTNp8g3yngN5QLkKmH4TL8uCXTofO4RinicJrMWbR2OHuO3lMuaNqwLmqF0= arcter@fedora

# EOT
# }
