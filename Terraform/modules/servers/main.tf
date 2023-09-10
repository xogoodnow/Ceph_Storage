resource "hcloud_server" "mon" {
  count = 3
  name         = "mon-${count.index}"
  image        = var.image_name
  server_type  = "cpx31"
  ssh_keys = [data.hcloud_ssh_key.key1.id,data.hcloud_ssh_key.key2.id,data.hcloud_ssh_key.key3.id]
  location = var.location
  network {
    network_id = data.hcloud_network.private-network.id
  }

}


resource "hcloud_server" "osd" {
  count = 3
  name         = "osd-${count.index}"
  image        = var.image_name
  server_type  = "cpx31"
  ssh_keys = [data.hcloud_ssh_key.key1.id,data.hcloud_ssh_key.key2.id,data.hcloud_ssh_key.key3.id]
  location = var.location
  network {
    network_id = data.hcloud_network.private-network.id
  }
}


resource "hcloud_server" "rgw" {
  count = 2
  name         = "rgw-${count.index}"
  image        = var.image_name
  server_type  = "cx21"
  ssh_keys = [data.hcloud_ssh_key.key1.id,data.hcloud_ssh_key.key2.id,data.hcloud_ssh_key.key3.id]
  location = var.location
  network {
    network_id = data.hcloud_network.private-network.id
  }
}


data "hcloud_network" "private-network" {
  name = "ceph-internal"

}



data "hcloud_ssh_key" "key1"  {
  name = "kang"

}

data "hcloud_ssh_key" "key2"  {
  name = "Kangkey"

}

data "hcloud_ssh_key" "key3" {
  name = "ssh_key_bastion"

}



resource "local_file" "inventory" {
  content = templatefile("${path.module}/inventory.tpl",
    {
      mon_ips = hcloud_server.mon.*.ipv4_address
      osd_ips = hcloud_server.osd.*.ipv4_address
      rgw_ips = hcloud_server.rgw.*.ipv4_address
    }
  )
  filename = "${path.module}/../../inventory.yaml"
}
