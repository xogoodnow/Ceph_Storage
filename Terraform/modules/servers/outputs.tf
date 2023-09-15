output "mon_ips" {
  value = hcloud_server.mon[*].ipv4_address
}

output "osd_ips" {
  value = hcloud_server.osd[*].ipv4_address
}

output "rgw_ips" {
  value = hcloud_server.rgw[*].ipv4_address
}

output "monitoring_ips" {
  value = hcloud_server.monitoring[*].network[*].ip
}


output "osd_private_ips" {
  value = hcloud_server.osd[*].network[*].ip
}

output "mon_private_ips" {
  value = hcloud_server.mon[*].network[*].ip
}


output "rgw_private_ips" {
  value = hcloud_server.rgw[*].network[*].ip
}
