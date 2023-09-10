resource "hcloud_network" "ceph-internal" {
  name     = "ceph-internal"
  ip_range = "10.0.0.0/8"

}

resource "hcloud_network_subnet" "ceph-internal-network" {
  network_id   = hcloud_network.ceph-internal.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = "10.0.0.0/8"
}