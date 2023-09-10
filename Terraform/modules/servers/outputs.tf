output "mon_ips" {
  value = hcloud_server.mon[*].ipv4_address
}

output "osd_ips" {
  value = hcloud_server.osd[*].ipv4_address
}

output "rgw_ips" {
  value = hcloud_server.rgw[*].ipv4_address
}

