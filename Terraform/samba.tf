resource "proxmox_vm_qemu" "samba" {

  name = "samba"
  desc = "Samba share"
  vmid = "10022"
  scsihw= "virtio-scsi-pci"
  target_node = "rimuru"

  clone = "ubuntu"

  agent = 1

  cores   = 10
  sockets = 1
  vcpus   = 0
  memory  = 10240
  cpu = "x86-64-v2-AES"

  os_type = "cloud-init"
  disk {
    size    = "200G"
    type    = "virtio"
    storage = "SSH"
  }

  network {
    model   = "virtio"
    bridge  = "k8s"
    macaddr = "7A:19:32:CF:F4:22"
  }

  nameserver = "192.168.255.254"
  ipconfig0  = "ip=192.168.254.22/24,gw=192.168.254.254"
  sshkeys    = <<-EOT
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDb+hKr3tBd+nvzbWgtd8FDMyJRQgdb15sjJXI+id68C/WfttYQ+2544XXt/pZIzZfgXx6OHjL4c9Wg817CayY1qLV1R2Uk6/2ieMYLDafDy+T2nvOiWIIJ9cJFj99l+sxXO0ILEdrrMrv8tzibTaActIa4wj+l7zg2qKKwPPzUTxBHz292pLpN60IAUVoAugNX0iS83CHC310wccWOMV2U5jw9cW7yyq+alykQ6Suk+bvW88S+zfcuRVoGDCQpYNl7K9i559lmfRllopS+RViczSAqKHGg//8UhFH/740ywY7zbejZKqj1M6LrIkwlNH8rHuwe3hclMwaNpYf3VcXOvmOJu7dbLseAxb5vWnxrNIt2iDqJ15RfTmEDVUaLax+KzS8DnuZ7YGUWs8rECbxsjdF698aGwLen7I9gube7rB4AHi/YVotbwTVVfD7dy2BPvL4ycTNp8g3yngN5QLkKmH4TL8uCXTofO4RinicJrMWbR2OHuO3lMuaNqwLmqF0= arcter@fedora
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzBGuyO+QTbfw0PhKxyk1KjgQnw7NEHuP0/eM7U0BAzXY2KYq3ykm4kDX2qKZwGQvhbPrIcI7CwTSpUYTnzDJqIOpsRz8ONNk8cYOhfHAm3RqxaQqyiegBzNtxLCNchxnom6xVV8/DFY+SQtNjTwSUh70GdSATKCOG5k3sU26TW7KyZYZwc8B5FYl5gRwFDaWUx7SjFQCOOQgSBkJXYJjyibqcEcFKNgGNnQy4inOGQ7PZy2jDXv1qkOXJBdyXu4x7ACNENFe6Prd9Zg1NtHPJxxhYDOX3AGoZYvHRIDEp5SSYlsU13UVJWCTuta+ExNvZPpN5rMsc6TEgJzPhWc5rqvh0wVDyOMzenc0Q5JdL87QQq82wuLDu25djnjHfzKKaEf7HwqodSnC6ebx4tiy7hAJWv+rP9kNa+B2XlGytugQD4tY7UWZaKagObrsPoy7JKz2Tfz/eHTMH3FWRgdX1nueMDX1kWdUjRnG9vKOki1mxI3xzm5Z7f5JLlsuWFcs= arcter@Router
EOT
}