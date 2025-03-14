terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.1-rc2"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://192.168.253.253:8006/api2/json"
  pm_tls_insecure = true
}

locals {
  ssh_keys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDb+hKr3tBd+nvzbWgtd8FDMyJRQgdb15sjJXI+id68C/WfttYQ+2544XXt/pZIzZfgXx6OHjL4c9Wg817CayY1qLV1R2Uk6/2ieMYLDafDy+T2nvOiWIIJ9cJFj99l+sxXO0ILEdrrMrv8tzibTaActIa4wj+l7zg2qKKwPPzUTxBHz292pLpN60IAUVoAugNX0iS83CHC310wccWOMV2U5jw9cW7yyq+alykQ6Suk+bvW88S+zfcuRVoGDCQpYNl7K9i559lmfRllopS+RViczSAqKHGg//8UhFH/740ywY7zbejZKqj1M6LrIkwlNH8rHuwe3hclMwaNpYf3VcXOvmOJu7dbLseAxb5vWnxrNIt2iDqJ15RfTmEDVUaLax+KzS8DnuZ7YGUWs8rECbxsjdF698aGwLen7I9gube7rB4AHi/YVotbwTVVfD7dy2BPvL4ycTNp8g3yngN5QLkKmH4TL8uCXTofO4RinicJrMWbR2OHuO3lMuaNqwLmqF0= arcter@fedora
  EOF
}
