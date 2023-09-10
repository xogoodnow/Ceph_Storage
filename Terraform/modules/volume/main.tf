
data "hcloud_server" "osd" {
  count = 3
  name = "osd-${count.index}"

}

resource "hcloud_volume" "osd_volumes" {
  count = length(data.hcloud_server.osd)
  name  = "osd-${count.index}-volume"
  size  = 200
  server_id = data.hcloud_server.osd[count.index].id
}