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
      number = 21
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
  scsihw= "virtio-scsi-pci"
  target_node = "rimuru"

  clone = "ubuntu"

  agent = 1

  cores   = each.value.cores
  sockets = 1
  vcpus   = 0
  memory  = each.value.memory
  cpu = "x86-64-v2-AES"

  os_type = "cloud-init"
  disk {
    size    = "32G"
    type    = "virtio"
    storage = "SSH"
  }
  # disk {
  #   size    = "100G"
  #   type    = "virtio"
  #   storage = "SSH"
  # }

  network {
    model   = "virtio"
    bridge  = "k8s"
    macaddr = "7A:19:32:CF:F4:${each.value.number}"
  }

  nameserver = "192.168.255.254"
  ipconfig0  = "ip=192.168.254.${each.value.number}/24,gw=192.168.254.254"
  sshkeys    = <<-EOT
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDb+hKr3tBd+nvzbWgtd8FDMyJRQgdb15sjJXI+id68C/WfttYQ+2544XXt/pZIzZfgXx6OHjL4c9Wg817CayY1qLV1R2Uk6/2ieMYLDafDy+T2nvOiWIIJ9cJFj99l+sxXO0ILEdrrMrv8tzibTaActIa4wj+l7zg2qKKwPPzUTxBHz292pLpN60IAUVoAugNX0iS83CHC310wccWOMV2U5jw9cW7yyq+alykQ6Suk+bvW88S+zfcuRVoGDCQpYNl7K9i559lmfRllopS+RViczSAqKHGg//8UhFH/740ywY7zbejZKqj1M6LrIkwlNH8rHuwe3hclMwaNpYf3VcXOvmOJu7dbLseAxb5vWnxrNIt2iDqJ15RfTmEDVUaLax+KzS8DnuZ7YGUWs8rECbxsjdF698aGwLen7I9gube7rB4AHi/YVotbwTVVfD7dy2BPvL4ycTNp8g3yngN5QLkKmH4TL8uCXTofO4RinicJrMWbR2OHuO3lMuaNqwLmqF0= arcter@fedora
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzBGuyO+QTbfw0PhKxyk1KjgQnw7NEHuP0/eM7U0BAzXY2KYq3ykm4kDX2qKZwGQvhbPrIcI7CwTSpUYTnzDJqIOpsRz8ONNk8cYOhfHAm3RqxaQqyiegBzNtxLCNchxnom6xVV8/DFY+SQtNjTwSUh70GdSATKCOG5k3sU26TW7KyZYZwc8B5FYl5gRwFDaWUx7SjFQCOOQgSBkJXYJjyibqcEcFKNgGNnQy4inOGQ7PZy2jDXv1qkOXJBdyXu4x7ACNENFe6Prd9Zg1NtHPJxxhYDOX3AGoZYvHRIDEp5SSYlsU13UVJWCTuta+ExNvZPpN5rMsc6TEgJzPhWc5rqvh0wVDyOMzenc0Q5JdL87QQq82wuLDu25djnjHfzKKaEf7HwqodSnC6ebx4tiy7hAJWv+rP9kNa+B2XlGytugQD4tY7UWZaKagObrsPoy7JKz2Tfz/eHTMH3FWRgdX1nueMDX1kWdUjRnG9vKOki1mxI3xzm5Z7f5JLlsuWFcs= arcter@Router
EOT
}

resource "proxmox_vm_qemu" "vm2" {
  for_each = { for k, v in local.support : k => v }

  name = each.key
  desc = "support infra for k8s"
  vmid = "100${each.value.number}"

  target_node = "rimuru"
  scsihw= "virtio-scsi-pci"
  clone = "ubuntu"

  agent = 1

  cores   = each.value.cores
  sockets = 1
  vcpus   = 0
  memory  = each.value.memory
  cpu= "x86-64-v2-AES"

  os_type = "cloud-init"
  disk {
    size    = each.value.size
    type    = "virtio"
    storage = each.value.type
  }
  # disk {
  #   size    = "100G"
  #   type    = "virtio"
  #   storage = "SSH"
  # }

  network {
    model   = "virtio"
    bridge  = "k8s"
    macaddr = "7A:19:32:CF:F5:${each.value.number}"
  }

  nameserver = "192.168.255.254"
  ipconfig0  = "ip=192.168.254.${each.value.number}/24,gw=192.168.254.254"
  sshkeys    = <<-EOT
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDb+hKr3tBd+nvzbWgtd8FDMyJRQgdb15sjJXI+id68C/WfttYQ+2544XXt/pZIzZfgXx6OHjL4c9Wg817CayY1qLV1R2Uk6/2ieMYLDafDy+T2nvOiWIIJ9cJFj99l+sxXO0ILEdrrMrv8tzibTaActIa4wj+l7zg2qKKwPPzUTxBHz292pLpN60IAUVoAugNX0iS83CHC310wccWOMV2U5jw9cW7yyq+alykQ6Suk+bvW88S+zfcuRVoGDCQpYNl7K9i559lmfRllopS+RViczSAqKHGg//8UhFH/740ywY7zbejZKqj1M6LrIkwlNH8rHuwe3hclMwaNpYf3VcXOvmOJu7dbLseAxb5vWnxrNIt2iDqJ15RfTmEDVUaLax+KzS8DnuZ7YGUWs8rECbxsjdF698aGwLen7I9gube7rB4AHi/YVotbwTVVfD7dy2BPvL4ycTNp8g3yngN5QLkKmH4TL8uCXTofO4RinicJrMWbR2OHuO3lMuaNqwLmqF0= arcter@fedora
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzBGuyO+QTbfw0PhKxyk1KjgQnw7NEHuP0/eM7U0BAzXY2KYq3ykm4kDX2qKZwGQvhbPrIcI7CwTSpUYTnzDJqIOpsRz8ONNk8cYOhfHAm3RqxaQqyiegBzNtxLCNchxnom6xVV8/DFY+SQtNjTwSUh70GdSATKCOG5k3sU26TW7KyZYZwc8B5FYl5gRwFDaWUx7SjFQCOOQgSBkJXYJjyibqcEcFKNgGNnQy4inOGQ7PZy2jDXv1qkOXJBdyXu4x7ACNENFe6Prd9Zg1NtHPJxxhYDOX3AGoZYvHRIDEp5SSYlsU13UVJWCTuta+ExNvZPpN5rMsc6TEgJzPhWc5rqvh0wVDyOMzenc0Q5JdL87QQq82wuLDu25djnjHfzKKaEf7HwqodSnC6ebx4tiy7hAJWv+rP9kNa+B2XlGytugQD4tY7UWZaKagObrsPoy7JKz2Tfz/eHTMH3FWRgdX1nueMDX1kWdUjRnG9vKOki1mxI3xzm5Z7f5JLlsuWFcs= arcter@Router
EOT
}
