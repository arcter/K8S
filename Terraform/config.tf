terraform {
  required_providers {
    proxmox = {
      source  = "Terraform-for-Proxmox/proxmox"
    }
  }

}

provider "proxmox" {
  pm_api_url      = "https://192.168.253.253:8006/api2/json"
  pm_tls_insecure = true
  pm_debug = true
}

locals {
  ssh_keys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDb+hKr3tBd+nvzbWgtd8FDMyJRQgdb15sjJXI+id68C/WfttYQ+2544XXt/pZIzZfgXx6OHjL4c9Wg817CayY1qLV1R2Uk6/2ieMYLDafDy+T2nvOiWIIJ9cJFj99l+sxXO0ILEdrrMrv8tzibTaActIa4wj+l7zg2qKKwPPzUTxBHz292pLpN60IAUVoAugNX0iS83CHC310wccWOMV2U5jw9cW7yyq+alykQ6Suk+bvW88S+zfcuRVoGDCQpYNl7K9i559lmfRllopS+RViczSAqKHGg//8UhFH/740ywY7zbejZKqj1M6LrIkwlNH8rHuwe3hclMwaNpYf3VcXOvmOJu7dbLseAxb5vWnxrNIt2iDqJ15RfTmEDVUaLax+KzS8DnuZ7YGUWs8rECbxsjdF698aGwLen7I9gube7rB4AHi/YVotbwTVVfD7dy2BPvL4ycTNp8g3yngN5QLkKmH4TL8uCXTofO4RinicJrMWbR2OHuO3lMuaNqwLmqF0= arcter@fedora
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzBGuyO+QTbfw0PhKxyk1KjgQnw7NEHuP0/eM7U0BAzXY2KYq3ykm4kDX2qKZwGQvhbPrIcI7CwTSpUYTnzDJqIOpsRz8ONNk8cYOhfHAm3RqxaQqyiegBzNtxLCNchxnom6xVV8/DFY+SQtNjTwSUh70GdSATKCOG5k3sU26TW7KyZYZwc8B5FYl5gRwFDaWUx7SjFQCOOQgSBkJXYJjyibqcEcFKNgGNnQy4inOGQ7PZy2jDXv1qkOXJBdyXu4x7ACNENFe6Prd9Zg1NtHPJxxhYDOX3AGoZYvHRIDEp5SSYlsU13UVJWCTuta+ExNvZPpN5rMsc6TEgJzPhWc5rqvh0wVDyOMzenc0Q5JdL87QQq82wuLDu25djnjHfzKKaEf7HwqodSnC6ebx4tiy7hAJWv+rP9kNa+B2XlGytugQD4tY7UWZaKagObrsPoy7JKz2Tfz/eHTMH3FWRgdX1nueMDX1kWdUjRnG9vKOki1mxI3xzm5Z7f5JLlsuWFcs= arcter@Router

  EOF
}
