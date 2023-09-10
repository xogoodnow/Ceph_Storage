resource "hcloud_network" "ceph-internal" {
  name     = "ceph-internal"
  ip_range = "10.0.0.0/8"
}