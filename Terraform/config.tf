terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.7.1"
    }
  }
  backend "http" {
  }
}

provider "proxmox" {
  pm_api_url      = "https://192.168.255.253:8006/api2/json"
  pm_tls_insecure = true
}

locals {
  ssh_keys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDPnAs56C2B5lGxAWnVV99i9voYRTtFsBEu7Co96d2e2HDpxcKfqi1VKEDZuysb8lSfyWAxt3R0g45hjx3j4W9JLnvdaq/WGjZls0NiIf80QjIwlRgL/3S7Xie1PFN0q2eeMc9rQ0kYYlPwCJ5jJ3jOEhzLSb/vHlsiXSwPZMOfumeq0OSPQxvk5xJiWRgyIwR6MCszZrCD3+kswIG51HPc61WJAcScjAyEyEswu3gP+UQRSrQuHTqdtMi37Q/0x6x/MqOWvNDeaxlwY/u/8FKSYxrkp8X5BBo+NyZvNLDBwjloeelnRUNZYplJUnH1j1+pRDzET/UBh/UIvi4wXvDbHhg7dB4obWVRm5sp9DqE3je6vD8TuyGQM55Uciq4l734FcDTWDHuM8mQIo3cMTCBPZdpUdWcUPx+2ojAV+PvD0nB5dHNFUyT6lLqToNUzKelQzf+dJSCUwENUfz6Y+l5q2fhfEv4MZFGtNgruWvAmuJcRd0XE6NreP7F1CWKuXU= arcter (git.sch.bme.hu)
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCioLa4HilrG1W/blzcBBUfoGblH3EjdiJCX/9FwRHbZltLkrV+Ldkp3zs4286zRdmaDP6StwK0i4QmAYyTGOoKlleNTKAwQsQV146vFj1BHUhZZSCKAYzByzGufsf6lIQCmE/zhbdHzRllW0PE2e37Mw9PdS/TGtiBRD7og9m7avUMVqpMQu43E+OXoXr49w8pNTClTwpY900mvJz8abgeHc6iQLOzSViIfmn6IH1vbVLNsAsrPjEvh9BSj2NaWF0eG29OQMM1EXYU7LpsBM8FD74qdBPSJmIGvMHHIPOTpfFAWfaBVBwaaIBBkOESvIE9ypn+VFiPWjg0Qb9Knt6SrCRgq/6RSCtggi7e9v3VAgnwyv2ACmGnjSTzVMUctN7KV3aWBW3dT5nQBV21ySPnwkXYuY2ICStuubFiz031RzDsq3PlTQYvLyUPqPGsQlW4ZhkGX6t9LG58mnlQkhKPdNT58Rr2FyqBHQWw3KQT1rnV9ELswJj1W33PoIzWuWlhY7nH/sL/XYijO2DneFyAyUMD6HomM0yC+5eri+NMeGh+zH6K9qDEXBaPpz5GY3rO9RWLxsLzfkRp62DFOFCGNnx7zD0RMI+m10hoJD5J6k3SZq99c+TZQv+hFWnPiDvcK9pzkgbsC/4Sa46DlIPoW5tszIF7H0CdKuXPPkMXMQ== arcter (git.sch.bme.hu)
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCZ9AKKGaAi+ymkFejNXmU6tynDIEjuCCioGgXHdFqbc5qzam6uFTzADiilNAVkfXWjpgjs0S88IXgMCU1R/lMKvfOWLQpGIxme8xyJeZpzvODNbC3B2WUpPtFXTZALP3lhPHyqYeAFGmr+XlWdyZfWA/uoHe209hJVY1SKkJcN8KSOfbIEF57HzZ960nYWNdKELXBxJlkgWYv+hYRCVZdAMP3m7mGAzMSqPAF2p2VI4b50hLLWRlUay1ejqb8VDhupK+hJmynr05Q8riOXJ7clJYDoDUyqZQhKgvJrUMSB39ZDSFSBF6z0KgdjPQL7JL/gu4NYcQWqRqdCGH3Wv5Nf6Y5CDxLx2+6KZYJBlqBnHQCZwJfASmGMJbeI//b3wANwg4XCH0cugqblqFFaB3H2IrmONnsWtBx4eZTaKAsENOoRcFoDFwQHbq6bLpelZtiwzknswYhnK8wae11uyRQUYk4sQG3BF/0yVnLjY2PtrxmApv3Up6FhXDFCxNiV/yE= arcter (git.sch.bme.hu)
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCx8uMS5W6eNADzGA+S3Do4nlvvzS0XxawmTvfrKNs8y5w68pFMjslHdJ845jxLE9u6RwIn21elkFeyVOpGMkHpDIordfQN0zMTGlfRGAT8eIbmE4r0i2nNn1Hj9ed1d9SYQvFTO8XG1gg+Wq46ETIg9ytnjy98eLoJmpBsySU6TPKRo2phIPa7kZV9mrDTWKRkEOWJkA9CvexVPNUCsrhmAnHlb4y8dMtG+4w9GkEdQvc6BRoLDqRFKGncUf+fH0mat+931mwJnO8GAkFzCLdF8XV/mtMGg7ljrIGO2ujLsKjpwT6qlyCtSuxdHc+8O7ma9O2Hsei4n5gtVWrO8vPE6bFS9YwZVqXD1mM2XuD/CswhxjWV8H9ryfXP8GA8GKwPgNykUwszxR/RdeI95vgwO2+5SVN6c+dAbMg/ytwd2NyZUMxqLbfsC6x81+nlG1wSSH7UBh6gXPdkvqUOL89Z2s/ufysWsKbn9kKRzE9WkYaMq4OTHvRjSTUUtTkDOi8= arcter (git.sch.bme.hu)
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDuGVH7FAd+czDjgraN9H98Xw40MGkJWk0DAXkVoXDla7+yqQ7hgrxiZBVT+XBA0bran9GXIItbVhx/pPI7OAw6S1TBzUB4MEo8wRY3wIte+RGqtCud5j7ZluL//QxBialgHHX/ajCHOh3evZ0QNMJohUEZSaWsi4+mE+EtsqGfhjX+qcVNAMe3PU+3MfBg2pqcx6G9k3gk/alKzgdnQnkdOh1wdApzP4bO3G0yfGFDuc8B86PMmm23cj78jqi4Dx1dL19b7bRVR4h0yTA0uY/W95kbACbAC0YojOMFqDAHVEWwd5gZFdxqLZH6hdtBA4TAi1bWvfGwPJyc1q24QQWt+R2ER4t5xzLcdUciYleEP0RGC9ol1D2Mxc1igFVR3psH93HEg7ZPFkBH1PFQLui64jaQuAom2Fx9C7iwr6wq86lD5mSTitXsNpa+0PR6r1yZ2W64wbYKzLyoYCA8CsCpf+1y5DYz17G7L0vzGjVjHdn/HBQ99Q8qNJQtZG1an2k= arcter (git.sch.bme.hu)
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDFD4ozrpbSl3w7D3rae8H3UKtnlD5q3JTEjbJmyKsaAVrcKKMB5SGG+AXflNsvzm1pVjY5dtLIt4u6v7REU7ugcEiljmx4lYY46Yh6FKIdTSQ8MF1w11J1SObpK5qer1YD39PvIb2WMvfeWoI9ds1jVeiUnpkMfA15x+iATKq3LyDDEiZIomnEtfG+6GE7TtsmPBrZ5Uy1yXPBs8x7OchEKj8aDEpehM9CPYp/g9TZGnulbvc41/gdtQCpR9QUM/9BtssSbT4FNarsBC8NxApdYqAuF20rU5kHwrQ3lZHzWW5w92Ng/TqRNA9uNKZsCgUuYw2cwC5so220NHwwHdWpO4snVHSqwKEvRDO2JjfOTFo1AupZYZrjYe8af4eUWPpzqJetqz481fy8pQCWn64T/QXcWHvCjGGRfiLvZ0vguz26UHX77ENp5j5Waf32xix2F6PGoJpOL3PqnW2OuZj2sjFTGQ2UP6SHLPTOYIAC5YZdrBfjBmkFbtcToM/Sm1ZyV0x+c2RCdT0WZrupKp2gmnEbO0Vnn12uE9NTfJCUYmhR+1eDLhNAqseQhgl+oJSigHbo6t3LwT/Ipplxa7cClO6yaGTifA5kI9+VQt7dHXQEUHclA+3U1/uYp4JSgz9mSh4NgQ/LdcwI1zSNg6ZYXB0BcGR9ppbe7JyW02tA6w== arcter (git.sch.bme.hu)
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCyCgL0QWtHomcUV/xBvl29J6z2xRwYjiwii8pl+4aoA7Gw2WnM58892p3xaaw3RP8J9xt1EzAmeOQmAtWzs24sPaGCa1BxyvqbHi5twHdH4sEkUVPkDmLhVxCSxB+LVrkjzqHPU5/bNGvOYAtsdqDttm3bV3oyy3R1K2HM9N1UCWUcvC/DugjTr9uvmWE1h4+YS/EHkeLQJKWpxhqogs4qibMW6c3hnsMx01LvU7P0DRkYn/NGdLq6f3R3A9+4ei6Zch8NJTgrPeRLtxm0BSAvaZPfHf2Z5ID1461bUVr9jgSXSEaiTZkQu93pyg4rQ+nDR7sF2IKdWO0wRcrdTyo6XMNLVfVRGVeQKgP/XmAgla1/AvgVvXoqXIOzb+bFGcrGkSZPTC9uExWuuw6rorjUTUsNOm/3uNEoiIBfvnxbVC4dwXDmIXr5Vo6WXHT7n0mgmNTPlUQqYgdQp4dMz0A6ZR8q2sKUHe5pXPek5k4BeuP730Q23X5myvE3c8YI8Xs= bandi@loptop
  EOF
}
